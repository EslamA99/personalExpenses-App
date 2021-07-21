import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  double amount;
  String day;
  double amountPercent;
  BarChart(this.day, this.amount, this.amountPercent);

  @override
  Widget build(BuildContext context) {
    return Container(child: LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '\$${amount.toStringAsFixed(0)}',
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.60,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                ),
                FractionallySizedBox(
                  heightFactor: amountPercent,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(day)))
        ],
      );
    }));
  }
}
