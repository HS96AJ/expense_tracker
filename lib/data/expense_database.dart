import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';



class ExpenseDataBase extends ChangeNotifier{
  static late Isar isar;
  // ignore: prefer_final_fields
  List<Expense> _allExpenses = [];

  static Future<void> initialize() async {
    final dir  = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema], directory: dir.path);
  }

  List<Expense> get allExpenses => _allExpenses;

  //Create New Expense
  Future<void> creatNewExpense (Expense newExpense) async{
    //add to database
    await isar.writeTxn(() => isar.expenses.put(newExpense));

    // re-read database
    await readExpenses();
  }

  //Read from database
  Future<void> readExpenses() async{
    List <Expense> fetchedExpenses = await isar.expenses.where().findAll();
    _allExpenses.clear();
    _allExpenses.addAll(fetchedExpenses);
    notifyListeners();
  }

  //Update Expense
  Future<void> updateExpenses(int id, Expense updatedExpense) async{
    updatedExpense.id = id;
    await isar.writeTxn(() => isar.expenses.put(updatedExpense));
    await readExpenses();
  }

  //Delete Expense
  Future<void> deleteExpenses(int id) async {
    await isar.writeTxn(() => isar.expenses.delete(id));
    await readExpenses();
  }
}
