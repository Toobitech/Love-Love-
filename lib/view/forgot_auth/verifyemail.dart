import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/controller/auth_controller.dart';
import '../../component/snackbar.dart';
import '../../helper/assets.dart';
import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/const_text.dart';
import '../../helper/spacer.dart';
import '../../component/social_login_button.dart';
import '../registerScreen.dart';

class verifyemail extends StatefulWidget {
  const verifyemail({super.key});

  @override
  State<verifyemail> createState() => _verifyemailState();
}

class _verifyemailState extends State<verifyemail> {
  final authController = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              vertical(40),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  AppImages.logo_Icon,
                  height: Get.height * 0.08,
                ),
              ),
              vertical(120),
              boldtext(AppColors.black, 28, "Verify Email"),

              vertical(40),
              // ? Padding(
              //     padding: const EdgeInsets.only(top: 15.0),
              //     child: CircularProgressIndicator(),
              //   )
              // :
              textarea(emailController, "Email"),

              vertical(40),
              buttonMain(0.6, "Next", () {
                if (emailController.text.isNotEmpty) {
                  authController.verifyemailcode(emailController.text);
                } else {
                  showInSnackBar('Please Enter Verification Email',
                      color: Colors.red);
                }
              }),

              vertical(200),
              socialLoginButton("Don`t have an account ? ", "Sign up", () {
                Get.to(() => RegisterScreen());
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget textarea(
    TextEditingController controller,
    String hint,
  ) {
    return SizedBox(
      width: Get.width * 0.7,
      height: 50,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          hintText: hint,
        ),
      ),
    );
  }
}
