import 'package:expense_tracker/constants/consts.dart';
import 'package:expense_tracker/controller/expenses_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseViewerScreen extends StatefulWidget {
  const ExpenseViewerScreen({super.key});

  @override
  State<ExpenseViewerScreen> createState() => _ExpenseViewerScreenState();
}

class _ExpenseViewerScreenState extends State<ExpenseViewerScreen> {
  var _selectedDate = "";
  var _selectedMonth = "";
  var _selectedYear = "";
  var _selectedCategory = "";
  final controller = Get.find<ExpensesController>();
  var expenseList = [];
  var _selectedUpperAmount = "";
  var _selectedLowerAmount = "";

  @override
  void initState() {
    super.initState();
    expenseList = controller.expensesList.toList();
  }

  @override
  Widget build(BuildContext context) {
    void filterList() {
      expenseList = controller.expensesList.where(
        (expense) {
          bool dateCond = (_selectedDate == "") ||
              (expense.date.day == int.parse(_selectedDate));
          bool monthCond = (_selectedMonth == "") ||
              (expense.date.month == int.parse(_selectedMonth));
          bool yearCond = (_selectedYear == "") ||
              (expense.date.year == int.parse(_selectedYear));
          bool categCond = (_selectedCategory == "") ||
              (expense.category == categories[_selectedCategory]);
          bool upperAmountCond = (_selectedUpperAmount == "") ||
              (expense.amount <= double.parse(_selectedUpperAmount));
          bool lowerAmountCond = (_selectedLowerAmount == "") ||
              (expense.amount >= double.parse(_selectedLowerAmount));
          
          return (dateCond && monthCond && yearCond && categCond && upperAmountCond && lowerAmountCond);
        },
      ).toList();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colBg2,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: colWhite,
          ),
          onPressed: () {
            Get.back();
            return;
          },
        ),
        title: "Exepenses".text.white.fontFamily(bold).size(24).make(),
      ),
      backgroundColor: colBg1,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                height: 70,
                width: 110,
                child: DropdownButtonFormField(
                  value: _selectedDate,
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
                      value: "",
                      child: Text(
                        "Date",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    ...List.generate(
                      31,
                      (index) => DropdownMenuItem<String>(
                        value: (index + 1).toString(),
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: colTxt1, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedDate = value!;
                    });
                  },
                ),
              ),
              5.widthBox,
              SizedBox(
                height: 70,
                width: 150,
                child: DropdownButtonFormField(
                  value: _selectedMonth,
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
                      value: "",
                      child: Text(
                        "Month",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    ...List.generate(
                      12,
                      (index) => DropdownMenuItem<String>(
                        value: (index + 1).toString(),
                        child: Text(
                          months[index + 1].toString(),
                          style: TextStyle(color: colTxt1, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedMonth = value!;
                    });
                  },
                ),
              ),
              5.widthBox,
              SizedBox(
                height: 70,
                width: 110,
                child: DropdownButtonFormField(
                  value: _selectedYear,
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
                      value: "",
                      child: Text(
                        "Year",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    ...List.generate(
                      3,
                      (index) => DropdownMenuItem<String>(
                        value: (DateTime.now().year - index).toString(),
                        child: Text(
                          (DateTime.now().year - index).toString(),
                          style: TextStyle(color: colTxt1, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedYear = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          5.heightBox,
          Row(
            children: [
              SizedBox(
                height: 70,
                width: 150,
                child: DropdownButtonFormField(
                  value: _selectedCategory,
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
                      value: "",
                      child: Text(
                        "Category",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "1",
                      child: Text(
                        "Work",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "2",
                      child: Text(
                        "Leisure",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "3",
                      child: Text(
                        "Bills",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "4",
                      child: Text(
                        "Groceries",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "5",
                      child: Text(
                        "Others",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
              ),
              5.widthBox,
              SizedBox(
                height: 70,
                width: 110,
                child: DropdownButtonFormField(
                  value: _selectedLowerAmount,
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
                      value: "",
                      child: Text(
                        "Lower",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    ...List.generate(
                      20,
                      (index) => DropdownMenuItem<String>(
                        value: (5000 * index).toString(),
                        child: Text(
                          "₹${5000 * index}",
                          style: TextStyle(color: colTxt1, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedLowerAmount = value!;
                    });
                  },
                ),
              ),
              5.widthBox,
              SizedBox(
                height: 70,
                width: 110,
                child: DropdownButtonFormField(
                  value: _selectedUpperAmount,
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
                      value: "",
                      child: Text(
                        "Upper",
                        style: TextStyle(color: colTxt1, fontSize: 18),
                      ),
                    ),
                    ...List.generate(
                      20,
                      (index) => DropdownMenuItem<String>(
                        value: (5000 * index).toString(),
                        child: Text(
                          "₹${5000 * index}",
                          style: TextStyle(color: colTxt1, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedUpperAmount = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          5.heightBox,
          SizedBox(
            height: 50,
            width: context.screenWidth - 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colBg2,
              ),
              onPressed: () {
                setState(() {
                  filterList();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.filter_alt,
                    color: colWhite,
                  ),
                  5.widthBox,
                  Text(
                    "Filter",
                    style: TextStyle(
                      color: colWhite,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
          5.heightBox,
          Divider(
            color: colTxt1.withOpacity(0.75),
          ),
          10.heightBox,
          GridView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.5,
              crossAxisCount: 2,
            ),
            itemCount: expenseList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed('/expenseDetails', arguments: expenseList[index]);
                  return;
                },
                child: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        expenseList[index].expenseTitle,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: colTxt1,
                          fontFamily: semibold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DateFormat('dd-MMMM-yyyy')
                            .format(expenseList[index].date)
                            .text
                            .color(colTxt1)
                            .fontFamily(regular)
                            .size(14)
                            .make(),
                      ),
                      5.heightBox,
                      Row(
                        children: [
                          "₹ ${expenseList[index].amount}"
                              .text
                              .color(colTxt1)
                              .fontFamily(regular)
                              .size(14)
                              .make(),
                          const Spacer(),
                          Icon(
                            expenseList[index].icon,
                            color: colTxt1,
                            size: 20,
                          ),
                        ],
                      ),
                      10.heightBox,
                    ],
                  ),
                )
                    .box
                    .white
                    .rounded
                    .shadowSm
                    .padding(const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ))
                    .margin(const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ))
                    .make(),
              );
            },
          ),
        ],
      )
          .box
          .margin(const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ))
          .make(),
    );
  }
}
