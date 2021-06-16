import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'room.dart';
import 'dart:math';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

List codes = [];

class _CreatePageState extends State<CreatePage> {
  var _code = ' ';
  var tcVisibility = false;
  bool isChecked = false;
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) =>
      new String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Simul Party'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Criar uma sala',
                style: TextStyle(fontSize: 27),
              ),
              SizedBox(height: 25),
              ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    ),
                    child: new Text(
                      'Gerar código da sala',
                      style: TextStyle(fontSize: 21),
                    ),
                    onPressed: () {
                      _code = getRandomString(7);
                      print(_code);
                      codes.add(_code);
                      print(codes);
                      setState(() {
                        tcVisibility = true;
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                  visible: tcVisibility,
                  child: Text('Seu código é: ' + _code,
                      style: TextStyle(
                        color: Colors.grey,
                      ))),
            ],
          ),
        ));
  }
}
