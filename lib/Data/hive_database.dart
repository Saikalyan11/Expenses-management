import 'package:expense_management/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  final _myBox = Hive.box('expense_database');

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormmated = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormmated);
    }
    _myBox.put('All_Expenses', allExpensesFormatted);
  }

  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get('All_Expenses') ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
