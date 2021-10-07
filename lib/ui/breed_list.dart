import 'package:flutter/material.dart';
import 'package:flutter_dopapp_provider/model/breedItem.dart';
import 'package:flutter_dopapp_provider/providers/breeds.dart';
import 'package:flutter_dopapp_provider/ui/breed_detail.dart';
import 'package:provider/provider.dart';

class BreedList extends StatefulWidget {
  @override
  _BreedListState createState() => _BreedListState();
}

class _BreedListState extends State<BreedList> {

  Widget buildList() {
    var breeds = context.watch<Breeds>().getBreedItems;
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        itemCount: breeds.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              child: Column(
                children: [
                  Container(
                      child: Text(
                        breeds[index].breedName,
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      margin: EdgeInsets.only(bottom: 5)),
                  Image.network(
                    breeds[index].breedImagePath,
                    fit: BoxFit.cover,
                    width: width / 2 - 50,
                    height: width / 2 - 50,
                  ),
                ],
              ),
              onTap: () => openDetailPage(breeds[index]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Breeds>(context, listen: false).resetBreeds();
    var breedList = Provider.of<Breeds>(context).getBreedItems;
    return Scaffold(
        appBar: AppBar(
          title: Text('List of breeds'),
        ),
        body: (breedList.isNotEmpty)
            ? buildList()
            : Center(child: CircularProgressIndicator()));
  }

  openDetailPage(BreedItem item) {
    Navigator.of(context).push(_goToBreedDetail(item));
  }
}

Route _goToBreedDetail(BreedItem breed) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        BreedDetail(breedItem: breed),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
