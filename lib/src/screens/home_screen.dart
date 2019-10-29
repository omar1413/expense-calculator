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
  final _transactionList = <Transaction>[];

  List<Transaction> get _recentTransactions {
    return _transactionList.where((ele) {
      return ele.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expense'),
      centerTitle: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            startAddNewTransaction(context);
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(recentTransactions: _recentTransactions)),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionList(
                _transactionList,
                onDelete: _deleteTransaction,
              ),
            ),
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

  void _deleteTransaction(String id) {
    setState(() {
      _transactionList.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (context) {
          return TransactionInput(
            onSubmit: (tx) {
              setState(() {
                _transactionList.add(tx);
              });
            },
          );
        });
  }
}
