import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // setting controllers for user input
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;
  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, selectedDate);
    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 10, 10),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      selectedDate == null
                          ? "No Data Chosen"
                          : "Picked Date: ${DateFormat.yMMMMEEEEd().format(selectedDate)}",
                    ),
                    FlatButton(
                      textColor: Colors.black,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _openDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.black,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _submitData,
              )
            ],
          ),
        ));
  }
}
