// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/helper/colors.dart';
import 'package:prolovelove/view/notificationscreen.dart';

import '../helper/assets.dart';
import '../view/messages/view/chat_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  VoidCallback? ontap;
  CustomAppBar({super.key, this.ontap});
//new kamlesh
  // final filterIncontroller = Get.put(FilterController());

  // final firebaseIncontroller = Get.put(ProfileViewController());
  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: Image.asset(
                      AppImages.settings,
                      color: AppColors.iconColor,
                      // colorBlendMode: BlendMode.modulate,
                      height: 28,
                      width: 28,
                    ),
                  ),
                  Spacer(),
                  // SizedBox(
                  //   width: Get.width * 0.55,
                  //   height: 40,
                  //   child: TextField(
                  //     style: const TextStyle(color: Colors.black),
                  //     readOnly: true,
                  //     //new kamlesh
                  //     // onTap: () => Get.to(() => SearchProfile()),
                  //     decoration: InputDecoration(
                  //         focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(25.0),
                  //           borderSide: const BorderSide(
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //         enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(25.0),
                  //           borderSide: const BorderSide(
                  //             color: Colors.white,
                  //             width: 1.0,
                  //           ),
                  //         ),
                  //         suffixIcon: const Icon(Icons.search),
                  //         fillColor: Colors.white,
                  //         filled: true,
                  //         contentPadding:
                  //             const EdgeInsets.only(top: 20, left: 20),
                  //         border: OutlineInputBorder(
                  //           borderSide: const BorderSide(width: 0),
                  //           borderRadius: BorderRadius.circular(25),
                  //         )),
                  //   ),
                  // ),

                  Spacer(),
                  IconButton(
                    onPressed: ontap ??
                        () {
                          Get.to(() => NotificationScreen());
                        },
                    icon: Image.asset(
                      AppImages.notifications,

                      color: AppColors.iconColor,
                      // colorBlendMode: BlendMode.modulate,
                      height: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: ontap ??
                        () {
                          Get.to(() => ChatScreen());
                        },
                    icon: Image.asset(
                      AppImages.chat_discover,

                      color: AppColors.iconColor,
                      // colorBlendMode: BlendMode.modulate,
                      height: 28,
                      width: 28,
                    ),
                  ),
                ],
              ),
              // IconButton(
              //     onPressed: () {
              //       Get.back();
              //     },
              //     icon: Icon(
              //       Icons.arrow_back_ios_new,
              //       color: AppColors.black,
              //     ))
            ],
          ),
        ),
      ),
    );

    //  Container(
    //   height: preferredSize.height,
    //   color: Colors.transparent,
    //   alignment: Alignment.center,
    //   child: Align(
    //     alignment: Alignment.bottomCenter,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [

    //       ],
    //     ),
    //   ),
    // );
  }
}
