import 'package:flutter/material.dart';
import 'package:flutter_dopapp_provider/model/breedItem.dart';
import 'package:flutter_dopapp_provider/providers/breeds.dart';
import 'package:provider/provider.dart';

class BreedDetail extends StatefulWidget {
  BreedDetail({this.breedItem});
  final BreedItem breedItem;

  @override
  _BreedDetailState createState() => _BreedDetailState();
}

class _BreedDetailState extends State<BreedDetail> {
  bool pressedRenew;

  @override
  void initState() {
    super.initState();
    pressedRenew = false;
  }

  Widget buildList() {
    var subBreeds = Provider.of<Breeds>(context).getSubBreeds;
    return Expanded(
      child: (subBreeds != null)
          ? (subBreeds.isNotEmpty)
              ? ListView.builder(
                  itemCount: subBreeds.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.pets),
                        title: Text(subBreeds[index]),
                      ),
                    );
                  })
              : Container(
                  color: Colors.white,
                )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildImageContainer() {
    var imagePathProvider = Provider.of<Breeds>(context,listen: false).getImaggePath;
    return Container(
      height: 300,
      child: (pressedRenew)
          ? (imagePathProvider != "")
              ? Image.network(
                  imagePathProvider,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                )
              : Center(child: CircularProgressIndicator())
          : Image.network(
              widget.breedItem.breedImagePath,
              fit: BoxFit.cover,
              width: 200,
              height: 200,
            ),
    );
  }

  Widget lineWidget() {
    return Container(height: 2, color: Colors.grey);
  }

  Widget subTitleWidget() {
    return Container(
        height: 30,
        child: Text("Sous-races",
            style: TextStyle(
              color: Colors.blue[600],
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            )));
  }

    Widget _renewButton() {
    return InkWell(
      onTap: () {
        resetImagePath();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.refresh,
            size: 40,
            color: Colors.white,
          )),
    );
  }

    Widget _myAppBar() {
    return AppBar(
      title: Text('Login'),
      actions: <Widget>[_renewButton()],
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Breeds>(context, listen: false)
        .resetSubBreeds(widget.breedItem);
    var pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _myAppBar(),
      body: Container(
        height: pageHeight,
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: [
            buildImageContainer(),
            lineWidget(),
            subTitleWidget(),
            buildList()
          ],
        ),
      ),
    );
  }

  void resetImagePath() {
    setState(() {
      pressedRenew = true;
    });
    Provider.of<Breeds>(context, listen: false).resetImage(widget.breedItem);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
