import 'package:expense_tracker/constants/consts.dart';
import 'package:expense_tracker/controller/profile_data_controller.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileDataController>();
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colBg1,
                  colBg2,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 35,
                  child: Image.asset(appLogo),
                ),
                const Spacer(),
                controller.userName.value.text.fontFamily(bold).white.size(32).make(),
                10.widthBox,
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
              color: colTxt1,
            ),
            title: "Settings"
                .text
                .fontFamily(semibold)
                .size(20)
                .color(colTxt1)
                .make(),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: colTxt1,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: colTxt1,
              size: 30,
            ),
            title: "Profile"
                .text
                .fontFamily(semibold)
                .size(20)
                .color(colTxt1)
                .make(),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: colTxt1,
            ),
            onTap: () {
              Get.toNamed('/profile');
            },
          ),
        ],
      ),
    );
  }
}
