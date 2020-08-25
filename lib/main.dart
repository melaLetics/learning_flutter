import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  int _totalScore = 0;
  static const _questions = [
    {
      'questionText': 'What\´s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Green', 'score': 5},
        {'text': 'White', 'score': 3},
        {'text': 'Pink', 'score': 0},
      ],
    },
    {
      'questionText': 'What\´s your favorite animal?',
      'answers': [
        {'text': 'Dog', 'score': 10},
        {'text': 'Cat', 'score': 3},
        {'text': 'Bat', 'score': 5},
        {'text': 'Spider', 'score': 1}
      ],
    },
    {
      'questionText': 'What\´s your favorite drink?',
      'answers': [
        {'text': 'Water', 'score': 10},
        {'text': 'Coffee', 'score': 3},
        {'text': 'Wine', 'score': 5},
        {'text': 'Beer', 'score': 1}
      ],
    },
  ];

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestions(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestions: _answerQuestions,
                questions: _questions,
                questionIndex: _questionIndex,
              )
            : Result(_totalScore, _restartQuiz),
      ),
    );
  }
}
