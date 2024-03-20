import 'package:expense_tracker/data/expense_database.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentMonth = DateFormat('MMMM y').format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  double totalSpendings = 0;
  List<Expense> currentMonthExpenses = [];
  @override
  void initState() {
    Provider.of<ExpenseDataBase>(context, listen: false).readExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Consumer<ExpenseDataBase>(
          builder: (context, value, child) {
                currentMonthExpenses.clear();
                totalSpendings = 0;
                for(var i=0; i<value.allExpenses.length ; i++){
                  if(DateFormat('MMMM y').format(value.allExpenses[i].date)==currentMonth){
                    currentMonthExpenses.add(value.allExpenses[i]);
                  }
                }
                for(var i=0; i<currentMonthExpenses.length ; i++){
                  totalSpendings += currentMonthExpenses[i].amount;
                }
          return Column(
            children: [
              GestureDetector(
                onTap: () async {
                  showMonthPicker(
                    context: context,
                    initialDate: selectedDate,
                    currentMonthTextColor: Colors.red
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        currentMonth = DateFormat('MMMM y').format(date);
                        selectedDate = date;
                      });
                    }
                  });
                },
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                        const Icon(FontAwesomeIcons.calendar, color: Colors.black)
                      ],
                    ),
                    const SizedBox(width: 8),
                    Text(currentMonth,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        totalSpendings.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                      const Text(
                        "Total Spent",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )
                    ]),
              ),
              const SizedBox(height: 40),
              Consumer<ExpenseDataBase>(builder: (context, value, child) {
                currentMonthExpenses.clear();
                totalSpendings = 0;
                for(var i=0; i<value.allExpenses.length ; i++){
                  if(DateFormat('MMMM y').format(value.allExpenses[i].date)==currentMonth){
                    currentMonthExpenses.add(value.allExpenses[i]);
                  }
                }
                for(var i=0; i<currentMonthExpenses.length ; i++){
                  totalSpendings += currentMonthExpenses[i].amount;
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: currentMonthExpenses.length,
                      itemBuilder: (context, index) {
                        Expense individualExpense = currentMonthExpenses[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 12),
                                      Text(individualExpense.name,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('\$${individualExpense.amount}',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                        Text(
                                            DateFormat('EEE dd')
                                                .format(individualExpense.date),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400))
                                      ])
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              })
            ],
          );}
        ),
      ),
    );
  }
}
