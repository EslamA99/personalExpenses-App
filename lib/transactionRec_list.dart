import 'package:flutter/material.dart';
import './transactionItem.dart';
import './models/Transaction.dart';

class TransactionListRec extends StatelessWidget {
  List<Transaction> txList;
  Function deleteTx;
  TransactionListRec(this.txList, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: txList.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: constraints.maxHeight * 0.2,
                      child: FittedBox(
                        child: Text(
                          "there is no transaction",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.1,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset('images/z.png', fit: BoxFit.cover),
                    ),
                  ],
                );
              },
            )
          : ListView(
              children: txList
                  .map((e) => TransactionItem(
                      key: ValueKey(e.id), tx: e, deleteTx: deleteTx))
                  .toList(),
            ),
    );
  }
}
