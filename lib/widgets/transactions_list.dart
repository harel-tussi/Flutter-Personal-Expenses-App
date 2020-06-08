import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;
  TransactionList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      height: 600,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  "No Transactions added yet!",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.contain,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                final Transaction tx = transactions[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                              "\$${tx.amount}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      title: Text("${tx.title}"),
                      subtitle: Text("${DateFormat.yMMMd().format(tx.date)}"),
                      trailing: IconButton(
                        onPressed: () {
                          removeTransaction(tx.id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[600],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
