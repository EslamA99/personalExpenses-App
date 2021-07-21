import 'package:flutter/material.dart';
import 'package:personalExpenses/barChart.dart';
import 'package:personalExpenses/models/Transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  double totalWeekSpent = 0;

  Chart(this.recentTransactions);

  List<Map<String, Object>> getTxForBar() {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSpent = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (weekDay.day == recentTransactions[i].date.day &&
            weekDay.month == recentTransactions[i].date.month &&
            weekDay.year == recentTransactions[i].date.year) {
          totalSpent += recentTransactions[i].amount;
        }
      }
      totalWeekSpent += totalSpent;
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSpent
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: getTxForBar().map((e) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: BarChart(
                      e['day'],
                      e['amount'],
                      totalWeekSpent == 0
                          ? 0.0
                          : (e['amount'] as double) / totalWeekSpent),
                );
              }).toList()),
        ),
      ),
    );
  }
}
