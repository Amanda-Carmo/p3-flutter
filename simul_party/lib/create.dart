import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'room.dart';
import 'dart:math';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var _code = ' ';
  bool isChecked = false;
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) =>
      new String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

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
              SizedBox(
                  width: 295,
                  child: CheckboxListTile(
                    title: Text('Visitantes podem pausar'),
                    // checkColor: Colors.white,
                    // fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  )),
              SizedBox(height: 13),
              SizedBox(
                width: 285,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Número de votos para pausar ou pular',
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
                    onPressed: () {
                      _code = getRandomString(6);
                      print(_code);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
