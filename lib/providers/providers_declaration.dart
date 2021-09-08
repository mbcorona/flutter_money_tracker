import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/contracts/i_local_storage.dart';
import 'package:money_tracker/models/espense_model.dart';
import 'package:money_tracker/providers/expenses.dart';

final localStorageProvider = Provider<ILocalStorage>(
  (ref) => throw UnimplementedError(),
);

final expensesProvider =
    StateNotifierProvider<Expenses, List<ExpenseModel>>(
  (ref) => Expenses(ref.read(localStorageProvider)),
);