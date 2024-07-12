import 'dart:math';

import 'package:expense_tracker/constants/consts.dart';
import 'package:expense_tracker/controller/expenses_controller.dart';
import 'package:expense_tracker/controller/profile_data_controller.dart';
import 'package:expense_tracker/view/charts/chart.dart';
import 'package:expense_tracker/view/drawer/main_drawer.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var profileController = Get.put(ProfileDataController());
  var expensesListContoller = Get.put(ExpensesController());
  var _selectedChart = "1";

  @override
  void initState() {
    super.initState();
    profileController.setUserData();
    expensesListContoller.setExpenseList();
  }

  @override
  Widget build(BuildContext context) {
    var expenses = expensesListContoller.expensesList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colBg2,
        title: "Xpense Tracker"
            .text
            .fontFamily(bold)
            .white
            .size(24)
            .fontWeight(FontWeight.w400)
            .make(),
      ),
      drawer: const MainDrawer(),
      backgroundColor: colBg1,
      body: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              10.heightBox,
              SizedBox(
                height: 70,
                width: context.screenWidth - 20,
                child: DropdownButtonFormField(
                  value: _selectedChart,
                  decoration: InputDecoration(
                    fillColor: colWhite,
                    filled: true,
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide(
                        color: colTxt1.withOpacity(0.25),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide(
                        color: colTxt1,
                      ),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: "1",
                      child: Text(
                        "Expenses by Dates(past 5 days)",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "2",
                      child: Text(
                        "Expenses by Categories(past 5 days)",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedChart = value!;
                    });
                  },
                ),
              ),
              5.heightBox,
              MainChart(whichChart: _selectedChart),
              Row(
                children: [
                  "Daily Expenditure".text.fontFamily(bold).size(18).make(),
                  const Spacer(),
                  // const Icon(Icons.arrow_outward, size: 25,),
                  IconButton(
                    onPressed: () {
                      Get.toNamed('/expenseViewer');
                      return;
                    },
                    iconSize: 25,
                    icon: const Icon(Icons.arrow_outward),
                  )
                ],
              )
                  .box
                  .white
                  // .withDecoration(BoxDecoration(border: Border.all(color: colTxt1.withOpacity(0.5))))
                  .shadowMd
                  .customRounded(const BorderRadius.horizontal(
                    left: Radius.circular(50),
                    right: Radius.circular(50),
                  ))
                  .padding(const EdgeInsets.symmetric(
                    horizontal: 20,
                    // vertical: 8,
                  ))
                  .margin(const EdgeInsets.only(
                      top: 20, bottom: 10, right: 10, left: 10))
                  .make(),
              // .onTap(() { }),
              Expanded(
                flex: 0,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 9) {
                      return Center(
                        child: const Text(
                          "Click on Daily Expenditure to view all",
                          style: TextStyle(
                            fontFamily: semibold,
                            fontSize: 16,
                          ),
                        ).box.make(),
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                expenses[index].expenseTitle,
                                style: const TextStyle(
                                  fontFamily: bold,
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              ),
                              const Spacer(),
                              Text(
                                "${expenses[index].date.day}/${expenses[index].date.month}/${expenses[index].date.year}",
                                style: const TextStyle(
                                    fontFamily: semibold, fontSize: 16),
                              ),
                              10.widthBox
                            ],
                          ),
                          5.heightBox,
                          Row(
                            children: [
                              Text(
                                "₹${expenses[index].amount.toString()}",
                                style: const TextStyle(
                                    fontFamily: semibold, fontSize: 16),
                              ),
                              const Spacer(),
                              Icon(
                                expenses[index].icon,
                                size: 25,
                              ),
                              10.widthBox
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: min(expenses.length, 10),
                )
                    .box
                    .white
                    .rounded
                    .shadowSm
                    .padding(const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ))
                    .margin(const EdgeInsets.only(
                        top: 5, left: 10, right: 10, bottom: 15))
                    .make(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: IconButton(
        onPressed: () {
          Get.toNamed('/addExpense');
        },
        icon: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      )
          .box
          .rounded
          .size(70, 70)
          .color(colButton)
          .margin(const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ))
          .make(),
    );
  }
}
