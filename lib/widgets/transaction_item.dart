import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.ctxTheme,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final ThemeData ctxTheme;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('€${transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: ctxTheme.textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 350
            ? FlatButton.icon(
                textColor: ctxTheme.errorColor,
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                onPressed: () => deleteTx(transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: ctxTheme.errorColor,
                onPressed: () => deleteTx(transaction.id),
              ),
      ),
    );
  }
}
