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
import 'forgotpassword_screen.dart';

// ignore: must_be_immutable
class VerifyCodeScreen extends StatefulWidget {
  int matchcode;
  String email;
  VerifyCodeScreen({super.key, required this.matchcode, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  TextEditingController codeController = TextEditingController();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    print('OTPVerify ${widget.matchcode}');
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
              boldtext(AppColors.black, 28, "Enter a Code"),

              vertical(40),
              // ? Padding(
              //     padding: const EdgeInsets.only(top: 15.0),
              //     child: CircularProgressIndicator(),
              //   )
              // :
              textarea(codeController, "Code"),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    authController.verifyemailcode(widget.email);
                  },
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),

              vertical(10),
              buttonMain(0.6, "Submit", () {
                if (codeController.text ==
                    authController.matechCode.toString()) {
                  Get.to(() => const ForgotPasswordScreen());
                } else {
                  showInSnackBar("Incorrect OTP", color: Colors.red);
                }
              }),

              vertical(130),
              socialLoginButton("Don`t have an account ? ", "Sign up", () {
                Get.to(() => const RegisterScreen());
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
        keyboardType: TextInputType.number,
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
