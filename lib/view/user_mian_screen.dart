import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/component/api_url.dart';
import 'package:prolovelove/controller/chat_controller.dart';
import 'package:prolovelove/controller/user_controller.dart';
import '../component/alertboxes.dart';
import '../component/bottomsmallStyle.dart';
import '../component/customAppBar.dart';
import '../component/userdrawer.dart';
import '../helper/colors.dart';
import '../helper/spacer.dart';
import 'edit_profile_form.dart';
import 'profile_view_screen.dart';

class UserMainScreen extends StatefulWidget {
  UserMainScreen({super.key});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  final controller = Get.put(UserController());
  final controller6 = Get.put(CharController());
  @override
  void initState() {
    super.initState();
    controller.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        return showExitPopup();
      },
      child: RefreshIndicator(
        onRefresh: () async {
          controller.getUserData();
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.white,
          drawer: Obx(() => userdrawer(
                userData: controller.loginUserData.value,
              )),
          appBar: CustomAppBar(),
          body: Stack(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(25, Get.height * 0.22, 25, 20),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Image.asset(
                        'assets/images/pic/lovelove.png',
                        height: Get.height * 0.2,
                      ),
                      Obx(
                        () => controller.isLoading.value
                            ? Center(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(
                                      color: AppColors.pink,
                                    )),
                              )
                            : Container(
                                margin: EdgeInsets.all(20),
                                padding: EdgeInsets.only(bottom: 25, top: 15),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.gradientLight,
                                        AppColors.gradientDark
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Icon(
                                                Icons.circle,
                                                size: 15,
                                                color: controller.loginUserData
                                                            .value.isLogin ==
                                                        1
                                                    ? Colors.green
                                                    : Colors.black,
                                              )),
                                          // Container(child: ),
                                          Text(
                                            controller.loginUserData.value
                                                        .isLogin ==
                                                    1
                                                ? 'online'
                                                : 'offline',
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        right: 15,
                                        child: GestureDetector(
                                          onTap: () {
                                            print('Go Profile Screen');
                                            Get.to(EditProfileForm(
                                              userData: controller
                                                  .loginUserData.value,
                                              backbuttonIs: true,
                                            ));
                                          },
                                          child: Container(
                                              child: Image.asset(
                                                  'assets/images/pic/pan.png')),
                                        )),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(ProfileViewScreen(
                                              userData: controller
                                                  .loginUserData.value,
                                            ));
                                          },
                                          child: Container(
                                            height: 100,
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.gradientLight,
                                                    width: 2),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      controller
                                                                  .loginUserData
                                                                  .value
                                                                  .profileImage
                                                                  ?.isNotEmpty ==
                                                              true
                                                          ? APiUrl.imagePath +
                                                              controller
                                                                  .loginUserData
                                                                  .value
                                                                  .profileImage
                                                                  .toString()
                                                          : APiUrl.defaultImage,
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        Obx(
                                          () => Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              controller
                                                          .loginUserData
                                                          .value
                                                          .firstName
                                                          ?.isNotEmpty ==
                                                      true
                                                  ? controller.loginUserData
                                                      .value.firstName!
                                                  : 'no Name',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Obx(
                                        //   () => Padding(
                                        //     padding: EdgeInsets.symmetric(
                                        //         vertical: 10),
                                        //     child: Text(
                                        //       controller.loginUserData.value
                                        //               .firstName?.isNotEmpty
                                        //           ? controller.loginUserData
                                        //               .value.firstName
                                        //               .toString()
                                        //           : 'no Name',
                                        //       style: TextStyle(
                                        //           fontSize: 20,
                                        //           color: AppColors.white,
                                        //           fontWeight: FontWeight.w600),
                                        //     ),
                                        //   ),
                                        // ),
                                        Obx(
                                          () => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30),
                                            child: Text(
                                              controller
                                                          .loginUserData
                                                          .value
                                                          .description
                                                          ?.isNotEmpty ==
                                                      true
                                                  ? controller.loginUserData
                                                      .value.description!
                                                  : 'no Description',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: false,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  )),
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
        ),
      ),
    );
  }
}
