import 'package:flutter/material.dart';

class MoneyCategory {
  final IconData icon;
  final String text;
  final Color color;
  final String code;

  MoneyCategory({
    required this.icon,
    required this.text,
    required this.color,
    required this.code,
  });
}

final categories = [
  MoneyCategory(icon: Icons.restaurant_menu, text: "Food & Drinks", color: Colors.orangeAccent, code: "food"),
  MoneyCategory(icon: Icons.shopping_bag_outlined, text: "Shopping", color: Colors.pink, code: "shopping"),
  MoneyCategory(icon: Icons.house_outlined, text: "Housing", color: Colors.blue, code: "houising"),
  MoneyCategory(icon: Icons.emoji_transportation, text: "Transportation", color: Colors.purple, code: "transportation"),
  MoneyCategory(icon: Icons.emoji_transportation, text: "Life & Entertainment", color: Colors.teal, code: "life"),
];
