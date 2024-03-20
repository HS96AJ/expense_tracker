import 'package:expense_tracker/screens/home/views/main_screen.dart';
import 'package:flutter/material.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title : "Expense Tracker",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.light(
          background: Colors.grey.shade200,
          onBackground: Colors.black,
          primary: const Color.fromRGBO(64, 66, 88, 1),
          secondary: const Color.fromRGBO(71, 78, 104, 1),
          tertiary: const Color.fromRGBO(80, 87, 122, 1),
          outline: Colors.grey

        )),
        home: const MainScreen(),
      );  
    }
}