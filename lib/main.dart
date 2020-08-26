import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Jacket',
      amount: 52.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Food Mask',
      amount: 3.79,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(children: [
          Container(
            width: double.infinity,
            child: Card(
              child: Text('CHART!'),
              elevation: 5,
              color: Colors.blue,
            ),
          ),
          Column(
            children: transactions.map((tx) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey, width: 1),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '€ ' + tx.amount.toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          tx.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMd().format(tx.date),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ]));
  }
}
