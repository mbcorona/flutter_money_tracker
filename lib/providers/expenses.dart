import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/contracts/i_local_storage.dart';
import 'package:money_tracker/models/espense_model.dart';

class Expenses extends StateNotifier<List<ExpenseModel>> {
  final String recordsKey = "records";
  final ILocalStorage storage;

  Expenses(this.storage) : super([]) {
    init();
  }

  void init() {
    final text = storage.getString(recordsKey) ?? "";
    if (text.isNotEmpty) {
      state = jsonDecode(text)
          .map<ExpenseModel>(
            (e) => ExpenseModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() as List<ExpenseModel>;
    }
  }

  void addExpense(ExpenseModel model) {
    state = [...state, model];
    _saveState();
  }

  void removeExpense(String id) {
    state = state.where((element) => element.id != id).toList();
    _saveState();
  }

  void _saveState() {
    storage.setString(
      recordsKey,
      jsonEncode(state.map((expense) => expense.toJson()).toList()),
    );
  }
}
