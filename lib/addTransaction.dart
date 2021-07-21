import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  Function fun;
  Function fun2;
  AddTransaction(this.fun);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime date;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                onSubmitted: (_) => pressedFun,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => pressedFun,
              ),
              Container(
                height: 100,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: date == null
                            ? Text("No date chosen")
                            : Text(DateFormat.yMMMd().format(date))),
                    FlatButton(
                      onPressed: dateFun,
                      child: Text("Enter Date"),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: pressedFun,
                color: Theme.of(context).primaryColor,
                child: Text("Add Transaction"),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  void pressedFun() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        date == null ||
        double.parse(amountController.text) <= 0) {
      return;
    }
    widget.fun(titleController.text, double.parse(amountController.text), date);
    Navigator.of(context).pop();
  }

  void dateFun() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate:
                DateTime(DateTime.now().subtract(Duration(days: 356)).year),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        date = value;
      });
    });
  }
}
