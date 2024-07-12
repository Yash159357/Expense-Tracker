import 'dart:math';
import 'package:expense_tracker/constants/consts.dart';
import 'package:expense_tracker/model/point.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key, required this.listToPlot});
  final List<PointChart> listToPlot;

  @override
  Widget build(BuildContext context) {
    double maxExpenseVal(List<PointChart> list) {
      double maxExpense = 0;
      for (int i = 0; i < 5; i++) {
        maxExpense = max(maxExpense, list[i].y.toDouble());
      }
      return maxExpense;
    }

    return AspectRatio(
      aspectRatio: 1.5,
      child: Center(
        child: SizedBox(
          width: context.screenWidth - 25,
          height: 500,
          child: BarChart(
            BarChartData(
              maxY: maxExpenseVal(listToPlot) * 1.25,
              minY: 0.0,
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int index = listToPlot.indexWhere(
                          (element) => element.x.day == value.toInt());
                      var formatter = DateFormat("dd-MMMM");
                      String date = formatter.format(listToPlot[index].x);
                      return date.text.color(colTxt1).fontFamily(semibold).make();
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              gridData: const FlGridData(
                drawVerticalLine: false,
              ),
              barGroups: listToPlot
                  .map(
                    (e) => BarChartGroupData(
                      x: e.x.day,
                      barRods: [
                        BarChartRodData(
                            toY: e.y,
                            color: colLoading1,
                            width: 25,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(1.5),
                              bottom: Radius.circular(1.5),
                            ))
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
