import 'package:expense_calaculator/src/models/transaction.dart';
import 'package:expense_calaculator/src/widgets/chart.dart';
import 'package:expense_calaculator/src/widgets/transaction_input.dart';
import 'package:expense_calaculator/src/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final transactionList = <Transaction>[
    Transaction(
      id: DateTime.now().toString(),
      title: 'New Shoes',
      amount: 52.25,
      date: DateTime.now(),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Weekly Groceries',
      amount: 20.25,
      date: DateTime.now(),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'شيش',
      amount: 40,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(),
            TransactionList(transactionList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startAddNewTransaction(context);
        },
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
    );
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (context) {
          return TransactionInput(
            onSubmit: (tx) {
              setState(() {
                transactionList.add(tx);
              });
            },
          );
        });
  }
}
