import 'package:flutter/material.dart';
import 'package:money_tracker/consts.dart';
import 'package:money_tracker/models/espense_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/providers_declaration.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    Key? key,
    required this.records,
  }) : super(key: key);

  final List<ExpenseModel> records;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(MConst.padding).copyWith(bottom: 100),
        itemCount: records.length,
        itemBuilder: (context, index) {
          final expense = records[records.length - index - 1];
          return Dismissible(
            key: Key(expense.id.toString()),
            onDismissed: (data) {
              context.read(expensesProvider.notifier).removeExpense(expense.id);
            },
            background: Container(
              margin: const EdgeInsets.only(bottom: MConst.padding),
              padding: const EdgeInsets.only(bottom: MConst.padding, right: MConst.padding),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(MConst.padding),
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: expense.category.color.withOpacity(MConst.opacity),
                borderRadius: BorderRadius.circular(MConst.padding),
              ),
              margin: const EdgeInsets.only(bottom: MConst.padding),
              child: ListTile(
                title: Text(
                  expense.description,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                ),
                subtitle: Text(
                  expense.category.text,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: Colors.white),
                ),
                leading: Icon(
                  expense.category.icon,
                  color: Colors.white,
                  size: 30,
                ),
                trailing: Text(
                  "\$${expense.amount.toStringAsFixed(2)}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
