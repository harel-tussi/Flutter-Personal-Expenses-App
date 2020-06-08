import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

import 'package:flutter_course/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  Chart(this.recentTransactions);

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: groupedTransactionsValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    totalSpending == 0
                        ? 0
                        : (data['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
