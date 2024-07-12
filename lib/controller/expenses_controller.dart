import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/constants/consts.dart';
import 'package:expense_tracker/model/point.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpensesController extends GetxController {
  var expensesList = [].obs;

  void addExpense({title, amount, category, date, desc}) {
    expensesList.add(Expense(
        expenseTitle: title,
        date: date,
        amount: amount,
        category: category,
        desc: desc));
    expensesList.refresh();
  }

  void setExpenseList() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDocRef =
            FirebaseFirestore.instance.collection("users").doc(user.uid);
        final expenseQuery = userDocRef.collection("expenses");
        final querySnapshot = await expenseQuery.get();

        var temp = querySnapshot.docs.map((doc) {
          final data = doc.data();

          return Expense(
              expenseTitle: data["title"].toString(),
              date: DateFormat("dd-MMMM-yyyy").parse(data["date"]),
              amount: double.parse(data["amount"]),
              category: categories[data["category"]]!,
              desc: data["desc"].toString());
        }).toList();

        for (int i = 0; i < temp.length; i++) {
          expensesList.add(temp[i]);
        }
      } catch (e) {
        print("Fail");
        GetSnackBar(
          title: "Expense Data Not Found!",
          message: e.toString(),
          duration: const Duration(seconds: 2),
          backgroundColor: colTxt1,
          borderRadius: 10,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
        );
      }
    }
    expensesList.refresh();
  }

  List<PointChart> getExpensesByDates() {
    DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    List<PointChart> expensebyDate = [
      PointChart(x: now.subtract(const Duration(days: 4)), y: 0),
      PointChart(x: now.subtract(const Duration(days: 3)), y: 0),
      PointChart(x: now.subtract(const Duration(days: 2)), y: 0),
      PointChart(x: now.subtract(const Duration(days: 1)), y: 0),
      PointChart(x: now, y: 0),
    ];
    for (int i = 0; i < expensesList.length; i++) {
      if (expensesList[i].date == now) {
        expensebyDate[4].y += expensesList[i].amount;
      } else if (expensesList[i].date ==
          now.subtract(const Duration(days: 1))) {
        expensebyDate[3].y += expensesList[i].amount;
      } else if (expensesList[i].date ==
          now.subtract(const Duration(days: 2))) {
        expensebyDate[2].y += expensesList[i].amount;
      } else if (expensesList[i].date ==
          now.subtract(const Duration(days: 3))) {
        expensebyDate[1].y += expensesList[i].amount;
      } else if (expensesList[i].date ==
          now.subtract(const Duration(days: 4))) {
        expensebyDate[0].y += expensesList[i].amount;
      }
    }
    return expensebyDate;
  }

  List<PieChartSector> getExpensebyCategories() {
    List<PieChartSector> expenseByCategories = [
      PieChartSector(
        x: Category.bills,
        y: 0,
        col: colBg2,
      ),
      PieChartSector(
        x: Category.work,
        y: 0,
        col: colBg3,
      ),
      PieChartSector(
        x: Category.groceries,
        y: 0,
        col: colTxt1,
      ),
      PieChartSector(
        x: Category.leisure,
        y: 0,
        col: colButton,
      ),
      PieChartSector(
        x: Category.miscellaneous,
        y: 0,
        col: colLoading1,
      ),
    ];
    for (int i = 0; i < expensesList.length; i++) {
      DateTime now = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      if (expensesList[i]
              .date
              .compareTo(now.subtract(const Duration(days: 5))) >
          0) {
        if (expensesList[i].category == Category.bills) {
          expenseByCategories[0].y += expensesList[i].amount;
        } else if (expensesList[i].category == Category.work) {
          expenseByCategories[1].y += expensesList[i].amount;
        } else if (expensesList[i].category == Category.groceries) {
          expenseByCategories[2].y += expensesList[i].amount;
        } else if (expensesList[i].category == Category.leisure) {
          expenseByCategories[3].y += expensesList[i].amount;
        } else if (expensesList[i].category == Category.miscellaneous) {
          expenseByCategories[4].y += expensesList[i].amount;
        }
      }
    }
    return expenseByCategories;
  }
}
