import 'package:expense_tracker/app.dart';
import 'package:expense_tracker/data/expense_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ExpenseDataBase.initialize();
  runApp(ChangeNotifierProvider(
    create: (context) => ExpenseDataBase(),
    child: const MyApp(),
  ));
}
