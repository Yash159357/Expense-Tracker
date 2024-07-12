import 'package:expense_tracker/constants/consts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseDetails extends StatelessWidget {
  const ExpenseDetails({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colBg2,
        title: expense.expenseTitle.text.white.fontFamily(bold).size(26).make(),
        leading: IconButton(
          onPressed: () {
            Get.back();
            return;
          },
          icon: Icon(
            Icons.arrow_back,
            color: colWhite,
            size: 30,
          ),
        ),
      ),
      backgroundColor: colBg1,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          2.heightBox,
          Divider(color: colTxt1.withOpacity(0.25),),
          2.heightBox,
          Row(
            children: [
              SizedBox(
                width: (context.screenWidth - 70) / 2,
                child: "Name: "
                    .text
                    .color(colTxt1)
                    .fontFamily(semibold)
                    .size(18)
                    .make(),
              ),
              Expanded(
                child: Text(
                  expense.expenseTitle,
                  softWrap: true,
                  maxLines: 10,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: colTxt1,
                    fontSize: 18,
                    fontFamily: semibold,
                  ),
                ),
              )
            ],
          ),
          2.heightBox,
          Divider(color: colTxt1.withOpacity(0.25),),
          2.heightBox,
          Row(
            children: [
              SizedBox(
                width: (context.screenWidth - 70) / 2,
                child: "Category: "
                    .text
                    .color(colTxt1)
                    .fontFamily(semibold)
                    .size(18)
                    .make(),
              ),
              Expanded(
                child: Text(
                  (expense.category.toString().replaceAll("Category.", "").upperCamelCase),
                  softWrap: true,
                  maxLines: 10,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: colTxt1,
                    fontSize: 18,
                    fontFamily: semibold,
                  ),
                ),
              )
            ],
          ),
          2.heightBox,
          Divider(color: colTxt1.withOpacity(0.25),),
          2.heightBox,
          Row(
            children: [
              SizedBox(
                width: (context.screenWidth - 70) / 2,
                child: "Amount: "
                    .text
                    .color(colTxt1)
                    .fontFamily(semibold)
                    .size(18)
                    .make(),
              ),
              Expanded(
                child: Text(
                  "₹${expense.amount}",
                  softWrap: true,
                  maxLines: 10,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: colTxt1,
                    fontSize: 18,
                    fontFamily: semibold,
                  ),
                ),
              )
            ],
          ),
          2.heightBox,
          Divider(color: colTxt1.withOpacity(0.25),),
          2.heightBox,
          Row(
            children: [
              SizedBox(
                width: (context.screenWidth - 70) / 2,
                child: "Date: "
                    .text
                    .color(colTxt1)
                    .fontFamily(semibold)
                    .size(18)
                    .make(),
              ),
              Expanded(
                child: Text(
                  DateFormat("dd-MMMM-yyyy").format(expense.date),
                  softWrap: true,
                  maxLines: 10,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: colTxt1,
                    fontSize: 18,
                    fontFamily: semibold,
                  ),
                ),
              )
            ],
          ),
          2.heightBox,
          Divider(color: colTxt1.withOpacity(0.25),),
          2.heightBox,
          Row(
            children: [
              SizedBox(
                width: (context.screenWidth - 70) / 2,
                child: "Description: "
                    .text
                    .color(colTxt1)
                    .fontFamily(semibold)
                    .size(18)
                    .make(),
              ),
              Expanded(
                child: Text(
                  expense.desc,
                  softWrap: true,
                  maxLines: 10,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: colTxt1,
                    fontSize: 18,
                    fontFamily: semibold,
                  ),
                ),
              )
            ],
          ),
          2.heightBox,
          Divider(color: colTxt1.withOpacity(0.25),),
          2.heightBox,
        ],
      )
          .box
          .margin(const EdgeInsets.all(15))
          .padding(const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ))
          .white
          .shadowSm
          .rounded
          .make(),
    );
  }
}
