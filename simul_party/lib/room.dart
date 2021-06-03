import 'package:flutter/material.dart';
import 'join.dart';
import 'main.dart';

class RoomGuestPage extends StatefulWidget {
  @override
  _RoomGuestPageState createState() => _RoomGuestPageState();
}

class _RoomGuestPageState extends State<RoomGuestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Simul Party'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(''),
            ],
          ),
        ));
  }
}
