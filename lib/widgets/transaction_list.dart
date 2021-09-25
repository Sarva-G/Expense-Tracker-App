import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expense_app/models/transaction.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? Column(
        children: <Widget>[
          SizedBox(
            height: 120,
          ),
          Container(
            height: 150,
            child: Image.asset(
              'assets/images/Transactions_Icon.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'No transactions added yet!',
            style: Theme.of(context).textTheme.title,
          ),
        ],
      ) : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            color: Colors.lime[50],
            margin: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: Text('\$${transactions[index].amount}'),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete_sweep_rounded,
                  size: 26,
                ),
                color: Colors.redAccent,
                onPressed: () => deleteTx(transactions[index].id),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      );
  }
}
