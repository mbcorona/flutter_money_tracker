import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_tracker/consts.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:money_tracker/models/espense_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/pages/add_expense/widgets/categories_selector.dart';
import 'package:money_tracker/providers/providers_declaration.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> with TickerProviderStateMixin {
  final expense = ExpenseModel(
    id: DateTime.now().toString(),
    description: "",
    amount: 0.0,
    category: categories.first,
  );

  late final AnimationController animation;
  bool expanded = false;
  double animationValue = 0.0;

  late final TextEditingController description;
  late final TextEditingController amount;

  void animationListener() {
    setState(() {
      animationValue = animation.value;
    });
  }

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animation.addListener(animationListener);

    description = TextEditingController();
    amount = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animation.removeListener(animationListener);
  }

  void toggleExpanded() {
    expanded = !expanded;
    if (expanded) {
      animation.forward();
    } else {
      expense.id = DateTime.now().toString();
      expense.description = description.text;
      expense.amount = double.tryParse(amount.text) ?? 00;

      if (expense.amount == 0) return;

      context.read(expensesProvider.notifier).addExpense(expense.clone());

      animation.reverse();
      description.text = "";
      amount.text = "";
    }
  }

  void onVerticalDrag(DragUpdateDetails details) {
    setState(() {
      animationValue -= details.primaryDelta! / 350;
      animationValue = animationValue.clamp(0, 1);
    });
  }

  void onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      if (animationValue > .5) {
        animation.forward(from: animationValue);
        expanded = true;
      } else {
        animation.reverse(from: animationValue);
        expanded = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: -500 * (1 - animationValue),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3 * animationValue,
              sigmaY: 3 * animationValue,
            ),
            child: GestureDetector(
              onVerticalDragUpdate: onVerticalDrag,
              onVerticalDragEnd: onVerticalDragEnd,
              child: Opacity(
                opacity: animationValue,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, .2],
                      colors: [Colors.white10.withOpacity(0.0), Colors.white],
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: MConst.padding,
                      ),
                      const Icon(
                        Icons.remove,
                        color: Colors.pink,
                        size: 50,
                      ),
                      CategoriesSelector(
                        value: expense.category.code,
                        onChanged: (value) {
                          setState(() {
                            expense.category = categories.firstWhere(
                              (element) => element.code == value,
                            );
                          });
                        },
                      ),
                      const SizedBox(
                        height: MConst.padding,
                      ),
                      if (animationValue > 0) buildForm(),
                      const SizedBox(
                        height: 110,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: buildFloatingBtn(size),
        ),
      ],
    );
  }

  Container buildFloatingBtn(Size size) {
    return Container(
      width: size.width,
      height: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, .5],
          colors: [
            Colors.white10.withOpacity(0.0),
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: toggleExpanded,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.pinkAccent.withOpacity(MConst.opacity),
              borderRadius: BorderRadius.circular(70),
            ),
            child: Transform.rotate(
              angle: 3.1416 * 2 * Curves.easeIn.transform(animationValue),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Icon(
                  expanded ? Icons.save : Icons.add,
                  key: Key(expanded.toString()),
                  size: 45,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: description,
              decoration: const InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.pink),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: MConst.padding,
            ),
            TextFormField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                labelStyle: TextStyle(color: Colors.pink),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
