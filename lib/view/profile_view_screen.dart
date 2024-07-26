// import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/component/api_url.dart';
import 'package:prolovelove/component/custom_backbutton.dart';
import 'package:prolovelove/model/user_model.dart';
import '../component/bottomsmallStyle.dart';
import '../helper/assets.dart';
import '../helper/colors.dart';
import '../helper/const_text.dart';
import '../helper/spacer.dart';

class ProfileViewScreen extends StatefulWidget {
  UserModel userData;
  ProfileViewScreen({super.key, required this.userData});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BottomSmallStyle(
          botom: true,
          topHeight: 0.5,
          body:
              //  GetX<ProfileViewController>(builder: (controller) {
              //   return
              // controller.isLoading.value == true
              //     ? Center(
              //         child: SizedBox(
              //             height: 40,
              //             width: 40,
              //             child: CircularProgressIndicator(
              //               color: Color(0xffE895BF),
              //             )),
              //       )
              //     :
              Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.04),
                  child: CustomBackButton(),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: SizedBox(
                //     height: Get.height * 0.10,
                //     child: CircleAvatar(
                //       backgroundColor: Colors.white,
                //       radius: 18,
                //       child: IconButton(
                //           onPressed: () {
                //             Get.back();
                //           },
                //           icon: Icon(
                //             Icons.arrow_back_ios_new,
                //             color: AppColors.pink,
                //             size: 20,
                //           )),
                //     ),
                //   ),
                // ),
                // vertical(Get.height * 0.125),
                SizedBox(
                  height: Get.height * 0.24,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        //new kamlesh
                        // if (controller
                        //     .userId[0].images!.isNotEmpty) {
                        //   Get.to(() => ImagePreviewList(
                        //       images: controller.userId[0].images!
                        //           .map((e) => e.image.toString())
                        //           .toList()));
                        // imagePreviewAlert();
                        // }
                      },
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: AppColors.pink,
                          radius: 75,
                          backgroundImage: NetworkImage(APiUrl.imagePath +
                              widget.userData.profileImage.toString()),
                          //new kamlesh
                          // "${AppUrl.impath}/${controller.userId[0].profile.toString()}"),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.092,
                  child: Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(AppImages.heart_blue)
                        //  appStorage.read(ACCOUNT_FOR) !=
                        //             '1' &&
                        //         appStorage.read(ACCOUNT_FOR) !=
                        //             'null'
                        //     ? controller.userId[0].isRecomended ==
                        //             true
                        //         ? Image.asset(
                        //             AppImages.recommendations_red)
                        //         : Image.asset(AppImages
                        //             .recommendations_white)
                        //     : controller.userId[0].isFriend ==
                        //             true
                        //         ? Image.asset(
                        //             AppImages.heart_blue)
                        //         : Image.asset(
                        //             AppImages.heart_grey)
                        ),
                  ),
                ),

                //new kamlesh
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         //new kamlesh
                //         // if (appStorage.read(ACCOUNT_FOR) != '1' &&
                //         //     appStorage.read(ACCOUNT_FOR) != 'null') {
                //         //   controller3.heartsend(
                //         //       controller.userId[0].id.toString(),
                //         //       recomendation: true);
                //         // } else {
                //         //   if (widget.isFrom == "Heart Received") {
                //         //     controller.accept(
                //         //         controller.userId[0].id.toString(),
                //         //         controller.userId[0].profile
                //         //             .toString(),
                //         //         controller.userId[0].firstName
                //         //             .toString());
                //         //   } else if (controller.userId[0].isFriend ==
                //         //       true) {
                //         //     print(controller.userId[0].profile
                //         //         .toString());
                //         //     Get.to(() => AnimationScreen(
                //         //           image:
                //         //               "${AppUrl.impath}/${controller.userId[0].profile.toString()}",
                //         //           userId: controller.userId[0].id!
                //         //               .toInt(),
                //         //           userName: controller
                //         //               .userId[0].firstName
                //         //               .toString(),
                //         //         ));
                //         //   } else {
                //         //     controller3.heartsend(
                //         //         controller.userId[0].id.toString());
                //         //   }
                //         // }
                //       },
                //       child: SizedBox(
                //         height: Get.height * 0.092,
                //         child: CircleAvatar(
                //             radius: 25,
                //             backgroundColor: Colors.transparent,
                //             child: Image.asset(AppImages.heart_grey)
                //             //  appStorage.read(ACCOUNT_FOR) !=
                //             //             '1' &&
                //             //         appStorage.read(ACCOUNT_FOR) !=
                //             //             'null'
                //             //     ? controller.userId[0].isRecomended ==
                //             //             true
                //             //         ? Image.asset(
                //             //             AppImages.recommendations_red)
                //             //         : Image.asset(AppImages
                //             //             .recommendations_white)
                //             //     : controller.userId[0].isFriend ==
                //             //             true
                //             //         ? Image.asset(
                //             //             AppImages.heart_blue)
                //             //         : Image.asset(
                //             //             AppImages.heart_grey)
                //             ),
                //       ),
                //     ),
                //     widget.isFrom != "Heart Received"
                //         ? SizedBox.shrink()
                //         : InkWell(
                //             onTap: () {
                //               // controller.cancel(
                //               //new kamlesh
                //               //     controller.userId[0].id.toString());
                //             },
                //             child: Padding(
                //               padding: const EdgeInsets.only(left: 20),
                //               child: SizedBox(
                //                 height: Get.height * 0.093,
                //                 child: const CircleAvatar(
                //                   radius: 25,
                //                   backgroundColor:
                //                       Color.fromARGB(255, 246, 231, 231),
                //                   child: Icon(
                //                     Icons.close,
                //                     color: Colors.black26,
                //                     size: 35,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //   ],
                // ),
                // vertical(10),
                // buttonMain(0.7, 'Chat', () async {
                //   await users
                //       .where('$USERID', isEqualTo: USERNAME.toString())
                //       .where(controller.userId[0].id.toString(),
                //           isEqualTo:
                //               controller.userId[0].firstName.toString())
                //       .get()
                //       .then((value) => {
                //             if (value.docs.isNotEmpty)
                //               {
                //                 print('exists'),
                //                 value.docs
                //                     .map((e) => Get.to(() => AppBarChat(
                //                           data: e.id,
                //                         )))
                //                     .toList()
                //               }
                //             else
                //               {
                //                 users.add({
                //                   'users': [
                //                     USERID,
                //                     controller.userId[0].id.toString(),
                //                   ],
                //                   '$USERID': USERNAME,
                //                   controller.userId[0].id.toString():
                //                       controller.userId[0].firstName
                //                           .toString(),
                //                 }).then((value) => print('printed'))
                //               }
                //           });

                //   // await users.add({
                //   //   'users': [
                //   //     USERID,
                //   //     controller.userId[0].id.toString(),
                //   //   ],
                //   //   '$USERID': 'Fullname',
                //   //   controller.userId[0].id.toString():
                //   //       controller.userId[0].firstName.toString(),
                //   // }).then((value) => print('printed'));
                // }),
                SizedBox(
                  height: Get.height * 0.12,
                ),
                Expanded(
                  // height: Get.height * 0.52,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boldtext(
                              AppColors.black,
                              20,
                              widget.userData.firstName.toString() +
                                  " " +
                                  widget.userData.lastName.toString()),
                          // boldtext(AppColors.black, 20,
                          //     "${controller.userId[0].firstName} , ${controller.userId[0].age} "),
                          vertical(10),
                          Row(
                            children: [
                              Icon(
                                Icons.bolt,
                                color: AppColors.pink,
                              ),
                              horizental(5),
                              mediumtext(AppColors.black, 12,
                                  widget.userData.profession.toString()),
                            ],
                          ),
                          vertical(15),
                          mediumtext(AppColors.black, 12, "About"),
                          vertical(15),
                          lighttext(AppColors.black, 14,
                              widget.userData.description.toString()),
                          vertical(15),
                          // mediumtext(AppColors.black, 12, "Interest"),
                          // vertical(15),
                          // boldtext(AppColors.black, 15, "N/A"),
                          // controller.userId[0].userIntrest!.length < 1
                          //     ? boldtext(AppColors.black, 15, "N/A")
                          //     : Wrap(
                          //         children: controller
                          //             .userId[0].userIntrest!
                          //             .map((index) => Container(
                          //                 padding: const EdgeInsets
                          //                     .symmetric(
                          //                     vertical: 7,
                          //                     horizontal: 20),
                          //                 margin:
                          //                     const EdgeInsets.all(5),
                          //                 decoration: BoxDecoration(
                          //                     color: AppColors.pink,
                          //                     borderRadius:
                          //                         BorderRadius
                          //                             .circular(15)),
                          //                 child: mediumtext(
                          //                     AppColors.white,
                          //                     10,
                          //                     "${index.intrest == null ? '' : index.intrest!.name}")))
                          //             .toList(),
                          //       ),
                          vertical(15),
                          // controller.userId[0].isMedicalCondition == 0
                          //     ? const SizedBox.shrink()
                          //     : mediumtext(AppColors.black, 12,
                          //         "Health Inconvenience"),
                          // mediumtext(
                          //     AppColors.black, 12, "Health Inconvenience"),
                          // vertical(15),
                          // boldtext(AppColors.black, 15, "N/A")
                          // controller.userId[0].isMedicalCondition == 0
                          //     ? const SizedBox.shrink()
                          //     : controller
                          //                 .userId[0]
                          //                 .userMedicalCondition!
                          //                 .length <
                          //             1
                          //         ? boldtext(
                          //             AppColors.black, 15, "N/A")
                          //         : Wrap(
                          //             children: controller.userId[0]
                          //                 .userMedicalCondition!
                          //                 .map((index) => Container(
                          //                     padding:
                          //                         const EdgeInsets.symmetric(
                          //                             vertical: 7,
                          //                             horizontal: 20),
                          //                     margin: const EdgeInsets
                          //                         .all(5),
                          //                     decoration: BoxDecoration(
                          //                         color:
                          //                             AppColors.pink,
                          //                         borderRadius:
                          //                             BorderRadius.circular(
                          //                                 15)),
                          //                     child: mediumtext(
                          //                         AppColors.white,
                          //                         10,
                          //                         "${index.medicalCondition!.name}")))
                          //                 .toList(),
                          //           ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
          // })
          ),
    );
  }
}
