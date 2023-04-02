import 'package:expense_management/Data/expense_data.dart';
import 'package:expense_management/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(hintText: 'Expense Name'),
            ),
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Expense Amount'),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );

    Provider.of<ExpenseData>(context, listen: false).addnewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Expense Tracking'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(value.getAllExpenseList()[index].name),
                  subtitle: Text(
                      value.getAllExpenseList()[index].dateTime.toString()),
                  trailing:
                      Text('Rs ' + value.getAllExpenseList()[index].amount),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
