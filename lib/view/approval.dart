import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/component/api_url.dart';
import 'package:prolovelove/component/globalvariables.dart';
import 'package:prolovelove/controller/chat_controller.dart';
import 'package:prolovelove/controller/user_controller.dart';
import 'package:prolovelove/helper/assets.dart';
import 'package:prolovelove/view/call/calling_service.dart';
import 'package:prolovelove/view/welcomescreen.dart';
import '../component/alertboxes.dart';
import '../component/bottomsmallStyle.dart';
import '../component/customAppBar.dart';
import '../component/userdrawer.dart';
import '../helper/colors.dart';
import '../helper/spacer.dart';
import 'edit_profile_form.dart';
import 'profile_view_screen.dart';

class ApprovalScreen extends StatefulWidget {
  final bool status;
  ApprovalScreen({super.key,required this.status});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
 
  // final controller = Get.put(UserController());
  // final controller6 = Get.put(CharController());
  // @override
  // void initState() {
  //   super.initState();
  //   controller.getUserData();
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Scaffold(
    
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      title: GestureDetector(
                        onTap: () {
                  // DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
                  // _dataBaseHelper.deleteAll();
                  onUserLogout();
                  appStorage.erase();
                  Get.to(WelcomeScreen());
                },

        child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 35,) ),

      ),
 
      body: Stack(
        children: [
          Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(25, Get.height * 0.25, 25, 20),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Image.asset(
                      'assets/images/pic/lovelove.png',
                      height: Get.height * 0.2,
                    ),
                    vertical(50),
                    Text(widget.status?"Your request to be a consultant is in review kindly wait!":"Your Request has been declined by the Admin you can't be a consultant ",textAlign: TextAlign.center, style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.w900),)
                    
                  ],
                )),
          ),
          BottomSmallStyle(
              body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                vertical(Get.height * 0.16),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
