import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function handler;
  final String answer;

  Answer(this.handler, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      child: RaisedButton(
        child: Text(this.answer),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: this.handler,
      ),
    );
  }
}
