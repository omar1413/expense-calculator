import 'package:date_format/date_format.dart';
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

  DateTime _choosenDate = DateTime.now();
  void _presentDatePicker() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2018),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );

    if (date == null) {
      return;
    }

    setState(() {
      _choosenDate = date;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        date: _choosenDate,
      ),
    );

    titleController.clear();
    amountController.clear();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 8.0,
            right: 8.0,
            left: 8.0,
            bottom: 8.0 + MediaQuery.of(context).viewInsets.bottom,
          ),
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
              Container(
                height: 60.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_choosenDate == null
                          ? 'No Date Chosen'
                          : 'Picked Date : ${formatDate(_choosenDate, [
                              yyyy,
                              '/',
                              mm,
                              '/',
                              dd
                            ])}'),
                    ),
                    FlatButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePicker,
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: _submit,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
