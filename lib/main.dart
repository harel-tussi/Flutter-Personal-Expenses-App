import 'package:flutter/material.dart';
import 'package:flutter_course/models/transaction.dart';
import 'package:flutter_course/widgets/chart.dart';
import 'package:flutter_course/widgets/new_transaction.dart';
import 'package:flutter_course/widgets/transactions_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          // primarySwatch: Color.fromRGBO(220, 220, 220, 0),
          fontFamily: "OpenSans",
          primaryColor: Colors.grey[900]),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // list of user transactions
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Food', amount: 45.99, date: DateTime.now()),
    Transaction(id: 't3', title: 'Car', amount: 24.99, date: DateTime.now()),
    Transaction(id: 't3', title: 'Car', amount: 24.99, date: DateTime.now()),
    Transaction(id: 't3', title: 'Car', amount: 24.99, date: DateTime.now()),
    Transaction(id: 't3', title: 'Car', amount: 24.99, date: DateTime.now()),
    Transaction(id: 't3', title: 'Car', amount: 24.99, date: DateTime.now()),
    Transaction(id: 't3', title: 'Car', amount: 24.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  // adding new transaction
  void _addNewTransaction(String title, double amount, DateTime date) {
    final _userTransactionsLength = _userTransactions.length + 1;
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: date,
      id: "t$_userTransactionsLength",
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => startAddNewTransaction(context),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Chart(_recentTransactions),
          TransactionList(_userTransactions, _removeTransaction)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
        backgroundColor: Colors.grey[900],
      ),
    );
  }
}
