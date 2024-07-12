import 'package:flutter/material.dart';
enum Category { work, leisure, bills, groceries, miscellaneous }

Map<Category, IconData> catIcons = {
  Category.work: Icons.work,
  Category.leisure: Icons.sports_basketball,
  Category.bills: Icons.monetization_on_outlined,
  Category.groceries: Icons.food_bank_outlined,
  Category.miscellaneous: Icons.question_mark,
};
