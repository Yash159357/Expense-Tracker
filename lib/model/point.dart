import 'package:expense_tracker/constants/consts.dart';

class PointChart {
  PointChart({
    required this.x,
    required this.y,
  });
  DateTime x;
  double y;
}

class PieChartSector {
  PieChartSector({
    required this.x,
    required this.y,
    required this.col,
  });
  Category x;
  double y;
  Color col;
}
