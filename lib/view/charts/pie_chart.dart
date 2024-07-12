import 'package:expense_tracker/model/point.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:expense_tracker/constants/consts.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key, required this.expenseByCategories});
  final List<PieChartSector> expenseByCategories;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Center(
        child: PieChart(
          PieChartData(
            centerSpaceRadius: 0,
            sections: List.generate(
              expenseByCategories.length,
              (index) => PieChartSectionData(
                color: expenseByCategories[index].col,
                value: expenseByCategories[index].y,
                title: "₹${expenseByCategories[index].y.toString()}",
                titleStyle: TextStyle(
                  color: colWhite,
                ),
                radius: 100,
              ),
            ),
          ),
          swapAnimationCurve: Curves.bounceOut,
          swapAnimationDuration: const Duration(seconds: 2),
        ),
      ),
    );
  }
}
