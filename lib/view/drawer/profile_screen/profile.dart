import 'package:expense_tracker/constants/consts.dart';
import 'package:expense_tracker/controller/profile_data_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileDataController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colBg2,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: colWhite,
            size: 26,
          ),
          onPressed: () {
            Get.back();
            return;
          },
        ),
        title: "Profile".text.white.fontFamily(bold).size(24).make(),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAllNamed('/splashScreen');
              return;
            },
            icon: Icon(
              Icons.logout_outlined,
              color: colWhite,
              size: 26,
            ),
          ),
        ],
      ),
      backgroundColor: colBg1,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: context.screenWidth / 2 - 30,
                child: "Name: "
                    .text
                    .size(18)
                    .color(colTxt1)
                    .fontFamily(semibold)
                    .make(),
              ),
              controller.userName.value
                  .text
                  .size(18)
                  .color(colTxt1)
                  .fontFamily(semibold)
                  .make(),
            ],
          ),
          Divider(
            color: colLoading1.withOpacity(0.25),
          ),
          Row(
            children: [
              SizedBox(
                width: context.screenWidth / 2 - 30,
                child: "Email: "
                    .text
                    .size(18)
                    .color(colTxt1)
                    .fontFamily(semibold)
                    .make(),
              ),
             controller.userEmail.value
                  .text
                  .overflow(TextOverflow.fade)
                  .size(18)
                  .color(colTxt1)
                  .fontFamily(semibold)
                  .make(),
            ],
          ),
          Divider(
            color: colLoading1.withOpacity(0.25),
          ),
          Row(
            children: [
              SizedBox(
                width: context.screenWidth / 2 - 30,
                child: "Password: "
                    .text
                    .size(18)
                    .color(colTxt1)
                    .fontFamily(semibold)
                    .make(),
              ),
              controller.userPswd.value
                  .text
                  .size(18)
                  .color(colTxt1)
                  .fontFamily(semibold)
                  .make(),
            ],
          ),
          Divider(
            color: colLoading1.withOpacity(0.25),
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colBg2,
                elevation: 1,
              ),
              child: Row(
                children: [
                  "Edit".text.white.fontFamily(semibold).size(18).make(),
                  10.widthBox,
                  Icon(
                    Icons.edit,
                    color: colWhite,
                    size: 25,
                  ),
                ],
              ),
            ),
          ).box.margin(const EdgeInsets.only(top: 10)).make(),
        ],
      )
          .box
          .color(Colors.grey.shade100)
          .margin(const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ))
          .padding(const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ))
          .rounded
          .shadowMd
          .make(),
    );
  }
}
