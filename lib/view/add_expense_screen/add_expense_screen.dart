import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/constants/consts.dart';
import 'package:expense_tracker/controller/expenses_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  var controller = Get.find<ExpensesController>();
  final _formkey = GlobalKey<FormState>();
  var _selectedCategory = "1";
  DateTime? _pickedDate;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descController = TextEditingController();

  void submit() {
    if (_formkey.currentState!.validate()) {
      if (_pickedDate != null) {
        controller.addExpense(
          title: _titleController.text,
          amount: double.parse(_amountController.text),
          date: _pickedDate,
          category: categories[_selectedCategory],
          desc: _descController.text,
        );
        final user = FirebaseAuth.instance.currentUser!;
        try {
          final userDocRef = FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection("expenses")
              .doc();
          userDocRef.set({
            "title": _titleController.text,
            "amount": _amountController.text,
            "date": DateFormat("dd-MMMM-yyyy").format(_pickedDate!),
            "category": _selectedCategory,
            "desc": _descController.text
          });
          Get.back();
        } catch (e) {
          Get.showSnackbar(
            GetSnackBar(
              title: "Expense not sent!",
              message: e.toString(),
              duration: const Duration(seconds: 2),
              backgroundColor: colTxt1,
              borderRadius: 10,
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
            ),
          );
        }
        Get.back();
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: "Invalid Input!",
            message: "You need to enter the date",
            duration: const Duration(seconds: 2),
            backgroundColor: colTxt1,
            borderRadius: 10,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
          ),
        );
      }
      Get.back();
      return;
    }
  }

  void _selectDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              brightness: Brightness.light,
              primary: colBg1,
              onPrimary: colTxt1,
              secondary: colBg1,
              onSecondary: colTxt1,
              error: Colors.red,
              onError: colWhite,
              background: colBg1,
              onBackground: colTxt1,
              surface: colWhite,
              onSurface: colTxt1,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colTxt1, // Change button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      _pickedDate = pickDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add Expense".text.white.fontFamily(bold).make(),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colWhite,
            size: 26,
          ),
          onPressed: () {
            Get.back();
            return;
          },
        ),
        backgroundColor: colBg2,
      ),
      backgroundColor: colBg1,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Expense Title"
                      .text
                      .fontFamily(semibold)
                      .color(colTxt1)
                      .size(18)
                      .make(),
                  5.heightBox,
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextFormField(
                      controller: _titleController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return "Please enter your title";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter you title",
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          color: colTxt2,
                        ),
                        isDense: true,
                        fillColor: colWhite,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colTxt1.withOpacity(0.25),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colTxt1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              20.heightBox,
              Column(
                children: [
                  Row(
                    children: [
                      "Amount"
                          .text
                          .fontFamily(semibold)
                          .color(colTxt1)
                          .size(18)
                          .make(),
                      const Spacer(),
                      "Category"
                          .text
                          .fontFamily(semibold)
                          .color(colTxt1)
                          .size(18)
                          .make(),
                      95.widthBox,
                    ],
                  ),
                  5.heightBox,
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return "Please enter your title";
                            }
                            if (!value.isNum) {
                              return "Please enter a number";
                            }
                            if (int.parse(value) < 0) {
                              return "Please enter a positive number";
                            }
                            return null;
                          },
                          maxLength: 7,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Enter you title",
                            hintStyle: TextStyle(
                              fontFamily: semibold,
                              color: colTxt2,
                            ),
                            isDense: true,
                            fillColor: colWhite,
                            filled: true,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colTxt1.withOpacity(0.25),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colTxt1),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 175,
                        height: 50,
                        child: DropdownButtonFormField(
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            fillColor: colWhite,
                            filled: true,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: "1",
                              child: "Work".text.make(),
                            ),
                            DropdownMenuItem(
                              value: "2",
                              child: "Leisure".text.make(),
                            ),
                            DropdownMenuItem(
                              value: "3",
                              child: "Bills".text.make(),
                            ),
                            DropdownMenuItem(
                              value: "4",
                              child: "Groceries".text.make(),
                            ),
                            const DropdownMenuItem(
                              value: "5",
                              child: Text("Miscellaneous",
                                  overflow: TextOverflow.fade),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
              20.heightBox,
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      size: 20,
                      color: colTxt1,
                    ),
                    onPressed: () {
                      _selectDate();
                      return;
                    },
                  ),
                  Container(
                    child: (_pickedDate == null
                            ? "Enter Date"
                            : DateFormat('dd-MM-yyyy').format(_pickedDate!))
                        .text
                        .color(colTxt1)
                        .fontFamily(semibold)
                        .size(16)
                        .make(),
                  )
                ],
              ),
              5.heightBox,
              Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Expense description"
                      .text
                      .fontFamily(semibold)
                      .color(colTxt1)
                      .size(18)
                      .make(),
                  5.heightBox,
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: TextFormField(
                      controller: _descController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return "Please enter your title";
                        }
                        return null;
                      },
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: "Enter you title",
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          color: colTxt2,
                        ),
                        fillColor: colWhite,
                        filled: true,
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colTxt1.withOpacity(0.25),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colTxt1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              275.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                      return;
                    },
                    child: Text(
                      "cancel",
                      style: TextStyle(
                        color: colTxt1,
                        fontFamily: semibold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  20.widthBox,
                  ElevatedButton(
                    onPressed: () async {
                      submit();
                      return;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colBg2,
                    ),
                    child: "Submit"
                        .text
                        .white
                        .fontFamily(semibold)
                        .size(16)
                        .make(),
                  ),
                ],
              ),
            ],
          )
              .box
              .padding(const EdgeInsets.symmetric(vertical: 20, horizontal: 15))
              .make(),
        ),
      ),
    );
  }
}
