import 'package:expense_calaculator/src/models/transaction.dart';
import 'package:expense_calaculator/src/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return transactionList.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'No transactions added yet',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Image.asset(
                  'assets/image/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(transactionList[index],
                  onDelete: onDelete);
            },
            itemCount: transactionList.length,
          );
  }

  TransactionList(this.transactionList, {this.onDelete});
}
