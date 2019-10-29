import 'package:expense_calaculator/src/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function onDelete;
  TransactionItem(this.transaction, {this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text('\$${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          '${transaction.title}',
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          '${formatDate(transaction.date, [M, ' ', dd, ',', yyyy])}',
          style: Theme.of(context).textTheme.subtitle,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            print('hello');
            onDelete(transaction.id);
          },
        ),
      ),
    );
  }
}
