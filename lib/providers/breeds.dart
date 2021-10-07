import 'package:flutter/material.dart';
import 'package:flutter_dopapp_provider/model/breedItem.dart';
import 'package:flutter_dopapp_provider/model/breedListResponse.dart';
import 'package:flutter_dopapp_provider/model/subBreedResponse.dart';
import 'package:flutter_dopapp_provider/services/network_handler.dart';
import 'package:flutter_dopapp_provider/services/route.dart';

class Breeds extends ChangeNotifier {
  var _breeds = List<BreedItem>.empty(growable: true);
  var _subBreeds = List<String>.empty(growable: true);
  var _imaggePath = "";
  var _loginStatus = '';
  var _alreadyLoaded = false;

  List<BreedItem> get getBreedItems {
    return _breeds;
  }

  List<String> get getSubBreeds {
    return _subBreeds;
  }

  String get getImaggePath {
    return _imaggePath;
  }

  String get getLoginState {
    return _loginStatus;
  }

  Future<void> resetBreeds() async {
    if (_alreadyLoaded) {
      return;
    } else {
      _alreadyLoaded = true;
      var response =
          await NetworkHandler().makeGetRequest(kGetAllBreedsURLString);

      if (response.statusCode == 200) {
        var breedList = List<BreedItem>.empty(growable: true);

        var list = breedListResponseFromJson(response.data).getBreedList();

        for (var filename in list) {
          /// <<<<==== changed line
          var urlSS = getRandomBreedImage(filename);

          var newResponse = await NetworkHandler().makeGetRequest(urlSS);
          if (newResponse.statusCode == 200) {
            var imagesPath = newResponse.data["message"];

            var newBreedItem =
                BreedItem(breedName: filename, breedImagePath: imagesPath);

            breedList.add(newBreedItem);
            _breeds = breedList;
            notifyListeners();
          } else {
            print("error: ${response.statusMessage}");
            throw Exception('Erreur dans la récupération des données');
          }
        }
        _breeds = breedList;
        notifyListeners();
      } else {
        throw Exception('Erreur dans la récupération des données');
      }
    }
  }

  Future<void> resetSubBreeds(BreedItem breedItem) async {
    String requestURLString = getSubBreedList(breedItem.breedName);
    var response = await NetworkHandler().makeGetRequest(requestURLString);

    if (response.statusCode == 200) {
      var subreeds = subBreedListFromJson(response.data);
      _subBreeds = subreeds.message;
      notifyListeners();
    } else {
      print(response.statusCode);
      print(response.data);
    }
  }

  Future<void> resetImage(BreedItem breedItem) async {
    String requestURLString = getRandomImageFromBreed(breedItem.breedName);
    var response = await NetworkHandler().makeGetRequest(requestURLString);
    if (response.statusCode == 200) {
      _imaggePath = response.data["message"];
      notifyListeners();
    } else {
      throw Exception('Erreur dans la récupération des données');
    }
  }

  Future<void> resetLoginState() async {
    var response = await NetworkHandler().makeGetRequest(kLoginURLString);
    _loginStatus = response.statusMessage + response.statusCode.toString();
    notifyListeners();
  }
}
