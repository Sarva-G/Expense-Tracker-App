import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Expensess Planner',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  final List<Transaction> userTransactions = [
    Transaction(
      id: 'T1',
      title: 'New Shoes',
      amount: 59.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T2',
      title: 'Weekly Groceries',
      amount: 16.55,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T3',
      title: 'Pizza',
      amount: 22.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T4',
      title: 'Petrol',
      amount: 10.5,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T5',
      title: 'Juice Pops',
      amount: 5.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T6',
      title: 'Slim Jims',
      amount: 2.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T7',
      title: 'Sweat Shirt',
      amount: 35.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T8',
      title: 'Socks',
      amount: 15.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T9',
      title: 'Jogging Tracks',
      amount: 25.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T10',
      title: 'Bag of Chips',
      amount: 9.00,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      id: DateTime.now().toString(),
      date: chosenDate,
    );
    setState(() {
      userTransactions.add(newTx);
    });
  }

  void _deleteSelection(String id) {
    setState(() {
      userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Transaction> get _recentTransactions {
    return userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Center(
                child: Icon(Icons.horizontal_rule_rounded, color: Colors.blueGrey),
              ),
              NewTransaction(_addNewTransaction),
            ],
          ),
        ),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      );
    },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
        ),
      ),
      isScrollControlled: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Expense Planner'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
              child: TransactionList(userTransactions, _deleteSelection),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
