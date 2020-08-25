import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function restartHandler;

  Result(this.resultScore, this.restartHandler);

  String get resultPhrase {
    if (resultScore >= 30) {
      return 'You are awesome!';
    } else if (resultScore > 20) {
      return 'You are pretty likeable';
    } else {
      return 'You are ... strange?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text('Restart Quiz'),
            textColor: Colors.blue,
            onPressed: restartHandler,
          ),
        ],
      ),
    );
  }
}
