import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/consts.dart';
import 'package:money_tracker/models/espense_model.dart';

class ExpensesPie extends StatefulWidget {
  const ExpensesPie({
    Key? key,
    required this.records,
  }) : super(key: key);

  final List<ExpenseModel> records;

  @override
  _ExpensesPieState createState() => _ExpensesPieState();
}

class _ExpensesPieState extends State<ExpensesPie> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var totalSpend = 0.0;
    final List<PieChartSectionData> slices = [];

    void proccessData() {
      final Map<String, ExpenseModel> map = {};
      for (final r in widget.records) {
        if (map.containsKey(r.category.text)) {
          map[r.category.text]?.amount += r.amount;
        } else {
          map[r.category.text] = r.clone();
        }
        totalSpend += r.amount;
      }
      for (var i = 0; i < map.length; i++) {
        final value = map.values.elementAt(i);
        slices.add(
          PieChartSectionData(
            radius: i == touchedIndex ? 50.0 : null,
            value: value.amount,
            color: value.category.color.withOpacity(MConst.opacity),
            showTitle: false,
            title: value.category.text,
          ),
        );
      }
    }

    proccessData();
    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sections: slices,
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 100,
              pieTouchData: PieTouchData(
                touchCallback: (PieTouchResponse pieTouchResponse) {
                  setState(() {
                    final desiredTouch =
                        pieTouchResponse.touchInput is! PointerExitEvent &&
                            pieTouchResponse.touchInput is! PointerUpEvent;
                    if (desiredTouch &&
                        pieTouchResponse.touchedSection != null) {
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    } else {
                      touchedIndex = -1;
                    }
                  });
                },
              ),
            ),
            swapAnimationDuration: const Duration(
              seconds: 5,
            ),
          ),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: touchedIndex == -1
                  ? RichText(
                      key: const Key("total_spent"),
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Total Spend:",
                              style: Theme.of(context).textTheme.headline6),
                          TextSpan(
                            text: '\n\$${totalSpend.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: slices[touchedIndex].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          TextSpan(
                            text:
                                '\n\$${slices[touchedIndex].value.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
