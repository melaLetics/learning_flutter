import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _index = 0;
  static const _texts = [
    'This is the first text',
    'This is the second text',
    'This is the third text',
    'This is the forth text',
    'This is the fifth text',
  ];

  void _switchText() {
    setState(() {
      _index = _index++ % _texts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First Exercise'),
        ),
        body: Control(myIndex: _index, texts: _texts, switchText: _switchText),
      ),
    );
  }
}

class Control extends StatelessWidget {
  final int myIndex;
  final List<String> texts;
  final Function switchText;

  Control(
      {@required this.myIndex,
      @required this.texts,
      @required this.switchText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          texts[myIndex],
        ),
        FlatButton(
          child: Text('Want to see another message'),
          textColor: Colors.blue,
          onPressed: switchText,
        )
      ],
    );
  }
}

class CustomText extends StatelessWidget {
  final String myText;

  CustomText(this.myText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
          myText,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ));
  }
}
