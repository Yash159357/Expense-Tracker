import 'package:expense_tracker/constants/consts.dart';
import 'package:expense_tracker/controller/expenses_controller.dart';
import 'package:expense_tracker/view/charts/line_chart.dart';
import 'package:expense_tracker/view/charts/pie_chart.dart';
import 'package:get/get.dart';

class MainChart extends StatelessWidget {
  const MainChart({super.key, required this.whichChart});
  final String whichChart;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ExpensesController>();
    return Obx(
      () => (whichChart == "1"
              ? LineChartWidget(
                  listToPlot: controller.getExpensesByDates(),
                )
              : Column(
                  children: [
                    PieChartWidget(
                      expenseByCategories: controller.getExpensebyCategories(),
                    ),
                    20.heightBox,
                    Column(
                      children: [
                        ...List.generate(
                          controller.getExpensebyCategories().length,
                          (index) => Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: controller
                                    .getExpensebyCategories()[index]
                                    .col,
                              ),
                              5.widthBox,
                              controller
                                  .getExpensebyCategories()[index]
                                  .x
                                  .toString()
                                  .replaceAll("Category.", "")
                                  .upperCamelCase
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .make(),
                            ],
                          ),
                        )
                      ],
                    ).box.padding(const EdgeInsets.only(left: 15, bottom: 10)).make()
                  ],
                ))
          .box
          .white
          .roundedLg
          .margin(const EdgeInsets.symmetric(horizontal: 5, vertical: 10))
          .padding(const EdgeInsets.only(
            right: 25,
            left: 5,
            bottom: 10,
            top: 25,
          ))
          .shadowMd
          .make(),
    );
  }
}
