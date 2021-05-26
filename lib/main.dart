import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Random random = Random();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isNumeric(String string) {
    return int.tryParse(string) != null;
  }

  void showAlertDialog(BuildContext context) {
    final Widget cancelButton = TextButton(
      child: const Text('Ok'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    final Widget continueButton = TextButton(
      child: const Text('Try again'),
      onPressed: () {
        setState(() {
          randomNumber = random.nextInt(101) + 1;
        });
        Navigator.pop(context);
      },
    );

    final AlertDialog alert = AlertDialog(
      title: const Text('Yop got it'),
      content: Text('The number was $randomNumber'),
      actions: <Widget>[
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  int randomNumber = random.nextInt(101) + 1;
  TextEditingController controller = TextEditingController();
  String? infoMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess my number'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "I'm thinking of a number between 1 and 100",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "It's your turn to guess my number",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              infoMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: const Text(
                    'Enter a number',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (isNumeric(controller.text)) {
                        final int number = int.parse(controller.text);
                        if (number > randomNumber) {
                          infoMessage = 'You tried $number. Try lower!';
                        } else if (number < randomNumber) {
                          infoMessage = 'You tried $number. Try higher!';
                        } else {
                          showAlertDialog(context);
                        }
                      }
                    });
                  },
                  child: const Text(
                    'Guess!',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
