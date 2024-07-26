import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../component/bottomsmallStyle.dart';
import '../component/custom_backbutton.dart';
import '../helper/colors.dart';
import '../helper/const_text.dart';
import '../helper/spacer.dart';
// import 'package:LoveLove/global/bottomsmallStyle.dart';
// import 'package:LoveLove/helpers/colors.dart';

// import '../../components/custom_backbutton.dart';
// import '../../helpers/const_text.dart';
// import '../../helpers/spacer.dart';
// import '../authentication/widgets/card_widget.dart';
// import 'NotificationController.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: IconButton(
      //       onPressed: () {
      //         Get.back();
      //       },
      //       icon: Icon(
      //         Icons.arrow_back_ios,
      //         color: AppColors.black,
      //       )),
      // ),
      body: BottomSmallStyle(
        topHeight: 0.23,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: CustomBackButton(),
                ),
              ),
              vertical(100),

              Center(
                child: Text(
                  'Terms & Condition',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.063,
                      fontWeight: FontWeight.w900),
                ),
              ),
              vertical(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: lighttext(
                    AppColors.black,
                    14,
                    "Welcome to our dating app! Before you use our app, please read these terms and conditions carefully as they form a legally binding agreement between you and our company.Eligibility: You must be at least 18 years old to use our dating app. By using our app, you confirm that you are 18 years old or above"
                    "User Account: You must create an account to use our dating app. You are responsible for maintaining the confidentiality of your account information, including your password. You agree"),
              ),
              vertical(30),
              Center(
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.063,
                      fontWeight: FontWeight.w900),
                ),
              ),
              vertical(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: lighttext(
                    AppColors.black,
                    14,
                    "Welcome to our dating app! Before you use our app, please read these terms and conditions carefully as they form a legally binding agreement between you and our company.Eligibility: You must be at least 18 years old to use our dating app. By using our app, you confirm that you are 18 years old or above"
                    "User Account: You must create an account to use our dating app. You are responsible for maintaining the confidentiality of your account information, including your password. You agree"),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: lighttext(
                      AppColors.black,
                      14,
                      "Eligibility: You must be at least 18 years old to use our dating app. By using our app, you confirm that you are 18 years old or above"
                      "User Account: You must create an account to use our dating app. You are responsible for maintaining the confidentiality of your account information, including your password. You agree")),
              // SizedBox(
              //   height: Get.height * 0.67,
              //   child: notifycontroller.NotifyList.isEmpty
              //       ? Center(
              //           child: boldtext(Colors.grey, 14, "No Data Available"))
              //       : ListView.builder(
              //           shrinkWrap: true,
              //           physics: AlwaysScrollableScrollPhysics(),
              //           padding: EdgeInsets.zero,
              //           itemCount: notifycontroller.NotifyList.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             return CardWidget(
              //               child: ListTile(
              //                 title: mediumtext(AppColors.white, 14,
              //                     "${notifycontroller.NotifyList[index].description}"),
              //                 trailing: mediumtext(AppColors.white, 10,
              //                     "${notifycontroller.NotifyList[index].createdAt.toString().split('T').first}"),
              //               ),
              //             );
              //           }),
              // )

              // )
            ],
          ),
        ),
      ),
    );
  }
}
