import 'package:expense_calaculator/src/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionInput extends StatefulWidget {
  final Function onSubmit;

  TransactionInput({this.onSubmit});

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _submit() {
    String title = titleController.text;
    String amount = amountController.text;
    try {
      if (title.isEmpty || amount.isEmpty || double.parse(amount) < 0) {
        return;
      }
    } catch (_) {
      return;
    }

    widget.onSubmit(
      Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: double.parse(amount),
        date: DateTime.now(),
      ),
    );

    titleController.clear();
    amountController.clear();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            onSubmitted: (val) => _submit(),
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (val) => _submit(),
            controller: amountController,
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: _submit,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
