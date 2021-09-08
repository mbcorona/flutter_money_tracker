import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/consts.dart';
import 'package:money_tracker/pages/add_expense/add_expense.dart';
import 'package:money_tracker/pages/home/widgets/expenses_pie.dart';
import 'package:money_tracker/pages/home/widgets/expenses_list.dart';
import 'package:money_tracker/providers/providers_declaration.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer(
            builder: (context, watch, child) {
              final expenses = watch(expensesProvider);
              return Column(
                children: [
                  SafeArea(
                    child: ExpensesPie(
                      records: expenses,
                    ),
                  ),
                  ExpensesList(
                    records: expenses,
                  )
                ],
              );
            },
          ),
          const AddExpense(),
        ],
      ),
    );
  }
}
