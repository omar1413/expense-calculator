import 'package:expense_calaculator/src/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<WeeklyTransaction> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (formatDate(recentTransactions[i].date, [yyyy, mm, dd]).toString() ==
            formatDate(weekDay, [yyyy, mm, dd]).toString()) {
          totalAmount += recentTransactions[i].amount;
        }
      }

      final transaction = WeeklyTransaction(
          weekDay: formatDate(weekDay, [D]), totalAmount: totalAmount);

      return transaction;
    }).reversed.toList();
  }

  double get weekTotalAmount {
    return groupedTransactionValues.fold(0.0, (sum, ele) {
      return sum + ele.totalAmount;
    });
  }

  const Chart({@required this.recentTransactions})
      : assert(recentTransactions != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: groupedTransactionValues.map((ele) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                lable: ele.weekDay.substring(0, 2),
                value: ele.totalAmount,
                totalPercentage: weekTotalAmount == 0
                    ? 0.0
                    : ele.totalAmount / weekTotalAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ChartBar extends StatelessWidget {
  final String lable;
  final double value;
  final double totalPercentage;

  const ChartBar({this.lable, this.value, this.totalPercentage});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constaraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constaraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$$value'),
              ),
            ),
            SizedBox(height: constaraints.maxHeight * 0.05),
            Container(
              height: constaraints.maxHeight * 0.60,
              width: 15,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: totalPercentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constaraints.maxHeight * 0.05),
            Container(
                height: constaraints.maxHeight * 0.15,
                child: FittedBox(child: Text('$lable'))),
          ],
        );
      },
    );
  }
}
