import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/controller/auth_controller.dart';
import '../../helper/assets.dart';
import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/const_text.dart';
import '../../helper/spacer.dart';
import '../component/alertboxes.dart';
import '../component/snackbar.dart';
import '../component/social_login_button.dart';
import 'forgot_auth/verifyemail.dart';
import 'registerScreen.dart';

class LoginScreen extends StatefulWidget {
  final String? fcmToken;
  const LoginScreen({super.key, this.fcmToken});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool viewPass = true;

  @override
  Widget build(BuildContext context) {
    print('loggin FCM Token');
    print(widget.fcmToken);
    return WillPopScope(
      onWillPop: () {
        return showExitPopup();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    vertical(8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        AppImages.logo_Icon,
                        height: Get.height * 0.08,
                      ),
                    ),
                    Image.asset(
                      AppImages.world_Icon,
                      height: Get.height * 0.28,
                    ),

                    boldtext(
                      AppColors.black,
                      28,
                      "Log In Now",
                    ),
                    vertical(10),
                    lighttext(AppColors.black, 12, "Are you here for"),
                    lighttext(
                        AppColors.black, 12, "yourself or for your friend?"),
                    vertical(25),
                    // ? Padding(
                    //     padding: const EdgeInsets.only(top: 15.0),
                    //     child: CircularProgressIndicator(),
                    //   )
                    // :
                    CustomTextFiled(emailController, "Email"),
                    vertical(10),
                    CustomTextFiled(passController, "Password"),

                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => const verifyemail());
                          },
                          child: const Text(
                            'Forget Password',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),

                    vertical(20),
                    buttonMain(0.55, "Log In", () {
                      if (emailController.text.isEmpty) {
                        showInSnackBar('Please Enter Email', color: Colors.red);
                      } else if (passController.text.isEmpty) {
                        showInSnackBar('Please Enter Password',
                            color: Colors.red);
                      } else {
                        authController.loginWithEmail(
                            emailController.text,
                            passController.text,
                            widget.fcmToken.toString(),
                            context);
                      }
                    }),
                    socialLoginButton("Don`t have an account ? ", "Sign up",
                        () {
                      Get.to(() => const RegisterScreen());
                    }),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget CustomTextFiled(TextEditingController controller, String hint) {
    return SizedBox(
      width: Get.width * 0.65,
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: hint == "Password" ? viewPass : false,
        decoration: InputDecoration(
          suffixIcon: hint == "Password"
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      viewPass = !viewPass;
                    });
                  },
                  icon: Icon(
                    viewPass
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.black,
                  ))
              : null,
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
