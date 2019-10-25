import 'package:expense_calaculator/src/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactionList;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return TransactionItem(_transactionList[index]);
        },
        itemCount: _transactionList.length,
      ),
    );
  }

  TransactionList(this._transactionList);
}

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2.0)),
            child: Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${transaction.title}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Text(
                '${formatDate(transaction.date, [M, ' ', dd, ',', yyyy])}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
