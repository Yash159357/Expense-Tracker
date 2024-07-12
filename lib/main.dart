import 'package:expense_tracker/constants/consts.dart';
import 'package:expense_tracker/view/add_expense_screen/add_expense_screen.dart';
import 'package:expense_tracker/view/auth_screen/login_screen.dart';
import 'package:expense_tracker/view/drawer/profile_screen/profile.dart';
import 'package:expense_tracker/view/expense_viewer/expense_details/expense_details.dart';
import 'package:expense_tracker/view/expense_viewer/expense_viewer.dart';
import 'package:expense_tracker/view/home_screen/home.dart';
import 'package:expense_tracker/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final List<GetPage> routes = [
  GetPage(
    name: '/splashScreen',
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: '/login',
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: '/home',
    page: () => const Home(),
  ),
  GetPage(
    name: '/addExpense',
    page: () => const AddExpenseScreen(),
  ),
  GetPage(
    name: '/profile',
    page: () => const ProfileScreen(),
  ),
  GetPage(
    name: '/expenseViewer',
    page: () => const ExpenseViewerScreen(),
  ),
  GetPage(
    name: '/expenseDetails',
    page: () => ExpenseDetails(
      expense: Get.arguments as Expense,
    ),
    arguments: Expense(
      amount: 0,
      category: Category.bills,
      date: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      desc: "",
      expenseTitle: "",
    ),
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme().copyWith(
          iconTheme: const IconThemeData().copyWith(
            color: Colors.white,
          ),
        ),
      ),
      // home: MainChart(),
      home: const SplashScreen(),
      initialRoute: '/splashScreen',
      getPages: routes,
    );
  }
}
