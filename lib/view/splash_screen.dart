import 'dart:async';

import 'package:expense_tracker/constants/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(
        seconds: 1,
        milliseconds: 500,
      ),
      () {
        if (FirebaseAuth.instance.currentUser == null) {
          Get.offAllNamed('/login');
        } else {
          Get.offAllNamed('/home');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colBg1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              appLogo,
              width: 150,
              height: 150,
            ).box.roundedFull.clip(Clip.antiAlias).shadowSm.make(),
            10.heightBox,
            "Expense Tracker App"
                .text
                .fontFamily(bold)
                .size(20)
                .fontWeight(FontWeight.bold)
                .make(),
            5.heightBox,
            "Made by - Yash".text.fontFamily(semibold).size(16).make(),
            const Spacer(),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(colLoading1),
            ),
            10.heightBox,
            "   Loading...".text.fontFamily(semibold).size(16).make(),
            50.heightBox,
          ],
        ),
      ),
    );
  }
}
