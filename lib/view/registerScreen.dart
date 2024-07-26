import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/controller/auth_controller.dart';
import 'package:prolovelove/view/welcomescreen.dart';
import '../../helper/assets.dart';
import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/const_text.dart';
import '../../helper/spacer.dart';
import '../component/snackbar.dart';
import '../component/social_login_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authController = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                vertical(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    AppImages.logo_Icon,
                    height: Get.height * 0.08,
                  ),
                ),
                vertical(10),
                Image.asset(
                  AppImages.chatLove,
                  height: Get.height * 0.18,
                ),
                boldtext(AppColors.black, 30, "Sign Up Now"),
                vertical(10),
                lighttext(
                    AppColors.black, 12, "Let’s Get Your Account Set Up!"),
                lighttext(
                    AppColors.black, 12, "This will hardly take 5 minutes."),
                vertical(25),
                customTextField(nameController, "Full Name"),
                vertical(10),
                customTextField(emailController, "Email"),
                vertical(10),
                customTextField(passController, "Password"),
                vertical(20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         setState(() {
                //           selected = true;
                //           selected1 = false;
                //         });
                //       },
                //       child: Container(
                //         width: Get.width * 0.3,
                //         height: Get.height * 0.07,
                //         decoration: BoxDecoration(
                //             color: selected == true
                //                 ? Color(0xff75A6D3)
                //                 : Colors.white,
                //             border: Border.all(
                //                 width: 1,
                //                 color: selected == true
                //                     ? Colors.transparent
                //                     : Colors.grey),
                //             borderRadius: const BorderRadius.all(
                //               Radius.circular(30.0),
                //             ),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Color(0xFF75A6D3),
                //                 blurRadius: 12,
                //                 offset: Offset(0, 4),
                //                 spreadRadius: 0,
                //               )
                //             ]),
                //         child: Center(
                //             child: mediumtext(
                //                 selected == true
                //                     ? AppColors.white
                //                     : Colors.black,
                //                 14,
                //                 'Yourself')),
                //       ),
                //     ),
                //     horizental(10),
                //     InkWell(
                //       onTap: () {
                //         setState(() {
                //           selected1 = true;
                //           selected = false;
                //         });
                //       },
                //       child: Container(
                //         width: Get.width * 0.3,
                //         height: Get.height * 0.07,
                //         decoration: BoxDecoration(
                //             color: selected1 == true
                //                 ? Color(0xff75A6D3)
                //                 : Colors.white,
                //             border: Border.all(
                //                 width: 1,
                //                 color: selected1 == true
                //                     ? Colors.transparent
                //                     : Colors.grey),
                //             borderRadius: const BorderRadius.all(
                //               Radius.circular(30.0),
                //             ),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Color(0xFF75A6D3),
                //                 blurRadius: 12,
                //                 offset: Offset(0, 4),
                //                 spreadRadius: 0,
                //               )
                //             ]),
                //         child: Center(
                //             child: mediumtext(
                //                 selected1 == true
                //                     ? AppColors.white
                //                     : Colors.black,
                //                 14,
                //                 'For Love One')),
                //       ),
                //     ),
                //   ],
                // ),

                vertical(30),
                buttonMain(0.55, "Sign Up", () {
                  if (nameController.text.isEmpty) {
                    showInSnackBar('Please Enter Full Name', color: Colors.red);
                  } else if (emailController.text.isEmpty) {
                    showInSnackBar('Please Enter Email', color: Colors.red);
                  } else if (passController.text.isEmpty) {
                    showInSnackBar('Please Enter Password', color: Colors.red);
                  }
                  //  else if (!selected && !selected1) {
                  //   showInSnackBar('Please Select Account Type',
                  //       color: Colors.red);
                  // }
                  else {
                    authController.registerWithEmail(nameController.text,
                        emailController.text, passController.text
                        // selected == true ? '1' : '0',
                        );
                  }
                }),
                socialLoginButton("Already have an account ?", "Log In", () {
                  Get.to(() => WelcomeScreen());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField(TextEditingController controller, String hint) {
    return SizedBox(
      width: Get.width * 0.65,
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: hint == "Password" ? hidePassword : false,
        decoration: InputDecoration(
          suffixIcon: hint == "Password"
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                    hidePassword
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
