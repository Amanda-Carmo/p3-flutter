import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
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
              SizedBox(height: 13),
              SizedBox(
                width: 290,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: ''),
                ),
              ),
              SizedBox(height: 13),
              SizedBox(
                width: 290,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Número de votos válidos para pausar ou pular',
                  ),
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
