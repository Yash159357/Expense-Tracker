import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/constants/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isLogin = true;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pswdController = TextEditingController();

  void onLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      if (_isLogin) {
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _pswdController.text);
      } else {
        final userCredentails =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text, password: _pswdController.text);
        
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredentails.user!.uid)
            .set({
          "name": _nameController.text,
          "email": _emailController.text,
          "pswd": _pswdController.text,
        });
      }
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Error!",
          message: e.message,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colBg1,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                appLogo,
                width: 150,
                height: 150,
              ).box.roundedFull.clip(Clip.antiAlias).shadowSm.make(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Visibility(
                      visible: !_isLogin,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Name"
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          5.heightBox,
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _nameController,
                            validator: (value) {
                              if (_isLogin) {
                                return null;
                              }
                              if (value == null || value.isEmpty) {
                                return "Please enter you name";
                              }
                              if (value.length < 3 || value.length > 12) {
                                return "Please enter between 3 and 12 characters";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "ABC",
                              hintStyle: TextStyle(
                                fontFamily: semibold,
                                color: colTxt2,
                              ),
                              isDense: true,
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colTxt1),
                              ),
                            ),
                          ),
                          5.heightBox,
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "E-mail"
                            .text
                            .white
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                        5.heightBox,
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your E-mail";
                            }
                            if (!value.contains("@gmail.com")) {
                              return "Invalied E-mail";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "ABC@gmail.com",
                            hintStyle: TextStyle(
                              fontFamily: semibold,
                              color: colTxt2,
                            ),
                            isDense: true,
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colTxt1),
                            ),
                          ),
                        ),
                        5.heightBox,
                      ],
                    ),
                    10.heightBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Password"
                            .text
                            .white
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                        5.heightBox,
                        TextFormField(
                          obscureText: true,
                          controller: _pswdController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            if (value.length < 3 || value.length > 8) {
                              return "Please enter between 3 and 8 characters";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "ABC123",
                            hintStyle: TextStyle(
                              fontFamily: semibold,
                              color: colTxt2,
                            ),
                            isDense: true,
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colTxt1),
                            ),
                          ),
                        ),
                        5.heightBox,
                      ],
                    ),
                    20.heightBox,
                    ElevatedButton(
                      onPressed: onLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colTxt1,
                      ),
                      child: _isLogin
                          ? "Login"
                              .text
                              .white
                              .size(18)
                              .fontFamily(semibold)
                              .make()
                          : "SignUp"
                              .text
                              .white
                              .size(18)
                              .fontFamily(semibold)
                              .make(),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: _isLogin == true
                            ? Text(
                                "Don't have an account?, Register Now",
                                style: TextStyle(color: colTxt1),
                              )
                            : Text(
                                "Already Registered? Log In",
                                style: TextStyle(
                                  color: colTxt1,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              )
                  .box
                  .margin(
                    const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                  )
                  .padding(
                    const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                  )
                  .rounded
                  .outerShadow
                  .color(Colors.green.shade400)
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
