import 'package:expense_tracker/constants/consts.dart';

class Expense {
  Expense(
      {required this.expenseTitle,
      required this.date,
      required this.amount,
      required this.category,
      required this.desc,
      }):icon = catIcons[category]!;
  final String expenseTitle;
  final DateTime date;
  final double amount;
  final Category category;
  final IconData icon;
  final String desc;
}
