import 'package:flutter/material.dart';
import 'package:personalExpenses/chart.dart';
import 'package:personalExpenses/transactionRec_list.dart';
import './models/Transaction.dart';
import './addTransaction.dart';

void main() {
  runApp(Mmm());
}

class Mmm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _userTransactions = [
    new Transaction(amount: 10, date: DateTime.now(), id: "ddss", title: "qq"),
    new Transaction(amount: 10, date: DateTime.now(), id: "aa", title: "qq"),
    new Transaction(amount: 10, date: DateTime.now(), id: "ff", title: "qq"),
    new Transaction(amount: 10, date: DateTime.now(), id: "ee", title: "qq"),
    new Transaction(amount: 10, date: DateTime.now(), id: "22", title: "qq"),
  ];
  bool switchFlag = false;

  DateTime date;

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => id == element.id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AddTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transaction> getRecentTransactions() {
    return (_userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    })).toList();
  }

  List<Widget> buildLandscape(
      MediaQueryData mediaQuery, AppBar appBar, Container tx) {
    return [
      Row(
        children: <Widget>[
          Text("Show chart"),
          Switch(
              value: switchFlag,
              onChanged: (val) {
                setState(() {
                  switchFlag = val;
                });
              })
        ],
      ),
      switchFlag
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(getRecentTransactions()))
          : tx,
    ];
  }

  List<Widget> buildPortrait(Container chart, Container tx) {
    return [chart, tx];
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text("Your Personal Expenses"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );

    final tx = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionListRec(_userTransactions, deleteTx));
    final chart = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(getRecentTransactions()));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape) ...buildLandscape(mediaQuery, appBar, tx),
            if (!isLandscape) ...buildPortrait(chart, tx)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
