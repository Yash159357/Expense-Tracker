import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/constants/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileDataController extends GetxController {
  var userName = "Name".obs;
  var userEmail = "E-mail".obs;
  var userPswd = "Pswd".obs;

  void setUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final userCredentials = FirebaseAuth.instance.currentUser!;
      try {
        var temp = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.uid)
            .get();
        userName.value = temp.get("name");
        userEmail.value = temp.get("email");
        userPswd.value = temp.get("pswd");
      } catch (e) {
        Get.showSnackbar(
          GetSnackBar(
            title: "Profile Data Not Found!",
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
    }
    // print("Name: ${userName.value}");
    // print("Email: ${userEmail.value}");
    // print("Pswd: ${userPswd.value}");
  }
}
