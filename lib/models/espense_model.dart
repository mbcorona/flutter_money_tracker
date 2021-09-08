import 'package:money_tracker/models/category_model.dart';

class ExpenseModel {
  String id;
  String description;
  double amount;
  MoneyCategory category;

  ExpenseModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.category,
  });

  ExpenseModel.fromJson(Map<String, dynamic> json)
      : id = json['id']! as String,
        description = json['description'] as String,
        amount = json['amount']! as double,
        category =
            categories.where((c) => c.code == (json["code"]! as String)).first;

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'description': description,
      'amount': amount,
      'code': category.code,
    };
  }

  ExpenseModel clone() {
    return ExpenseModel(
      id: id,
      description: description,
      category: category,
      amount: amount,
    );
  }
}
