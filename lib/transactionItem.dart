import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/Transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.tx,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction tx;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color randomColor;
  @override
  void initState() {
    const colors = [Colors.black, Colors.blue, Colors.red, Colors.purple];
    randomColor = colors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(5),
      child: (ListTile(
        leading: CircleAvatar(
          backgroundColor: randomColor,
          radius: 30,
          child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                  child: Text("\$${widget.tx.amount.toStringAsFixed(2)}"))),
        ),
        title: Text(widget.tx.title),
        subtitle: Text(DateFormat.yMMMd().format(widget.tx.date)),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            widget.deleteTx(widget.tx.id);
          },
          color: Theme.of(context).primaryColorDark,
        ),
      )),
    );
  }
}
