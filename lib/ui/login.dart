import 'package:flutter/material.dart';
import 'package:flutter_dopapp_provider/providers/breeds.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Widget buildStatusText() {
    var loginState = Provider.of<Breeds>(context).getLoginState;
    return (loginState != "")
        ? Center(
            child: Text(
            '${context.watch<Breeds>().getLoginState}',
            style: TextStyle(fontSize: 30, color: Colors.green),
          ))
        : Center(child: CircularProgressIndicator());
  }

  Widget _renewButton() {
    return InkWell(
      onTap: () {
        pressedRenew();
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
    Provider.of<Breeds>(context, listen: false).resetLoginState();

    return Scaffold(appBar: _myAppBar(), body: buildStatusText());
  }

  Future<void> pressedRenew() async {
    Provider.of<Breeds>(context, listen: false).resetLoginState();
  }
}
