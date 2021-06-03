import 'package:flutter/material.dart';
import 'main.dart';
import 'room.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
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
                'Ingressar em uma sala',
                style: TextStyle(fontSize: 27),
              ),
              SizedBox(height: 13),
              SizedBox(
                width: 290,
                child: TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade800, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0)),
                      labelText: 'Insira o código da sala'),
                ),
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
                      'Confirmar',
                      style: TextStyle(fontSize: 21),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
