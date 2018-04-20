import 'package:flutter/material.dart';

Counter getRaisedButtonState() {
  return new Counter();
}

class Counter extends StatefulWidget {
  @override
  raisedButtonState createState() => new raisedButtonState();
}

class raisedButtonState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new RaisedButton(
          onPressed: _increment,
          child: new Text('添加'),
        ),
        new Text('Count: $_counter'),
      ],
    );
  }
}
