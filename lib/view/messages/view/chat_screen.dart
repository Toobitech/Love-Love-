import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/component/custom_backbutton.dart';
import '../../../component/alertboxes.dart';
import '../../../component/api_url.dart';
import '../../../component/bottomsmallStyle.dart';
import '../../../component/globalvariables.dart';
import '../../../controller/chat_controller.dart';
import '../../../helper/assets.dart';
import '../../../helper/colors.dart';
import '../../../helper/const_text.dart';
import '../../../helper/spacer.dart';
import '../widgets/userchatWidget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: BottomSmallStyle(
          top: false,
          body: Column(
            children: [
              vertical(Get.height * 0.1),
              // SizedBox(
              //   height: 80,
              //   width: Get.width,
              //   child: Center(
              //     child: ListView.builder(
              //         shrinkWrap: true,
              //         scrollDirection: Axis.horizontal,
              //         itemCount: 4,
              //         itemBuilder: (BuildContext, int index) {
              //           return Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 10),
              //             child: Column(
              //               children: [
              //                 CircleAvatar(
              //                   backgroundColor: Colors.black,
              //                   radius: 25,
              //                   child: CircleAvatar(
              //                     radius: 24,
              //                     backgroundColor: const Color(0xffE895BF),
              //                     backgroundImage:
              //                         AssetImage(AppImages.personimg),
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   height: 10,
              //                 ),
              //                 Container(
              //                   width: 50,
              //                   height: 3,
              //                   color: Color(0xffD9D9D9),
              //                 )
              //               ],
              //             ),
              //           );
              //         }),
              //   ),
              // ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .where('userId',
                          arrayContainsAny: [appStorage.read(USERID)])
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.pink,
                          ),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: boldtext(Colors.grey, 14,
                                "Something wen't wrong try later"),
                          );
                        } else {
                          List datamsg =
                              snapshot.data!.docs.map((e) => e.data()).toList();
                          List dataId =
                              snapshot.data!.docs.map((e) => e.id).toList();

                          return Expanded(
                              child: datamsg.isEmpty
                                  ? Center(
                                      child: boldtext(Colors.grey, 14,
                                          "No Chats Available"))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: datamsg.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return datamsg[index]['msg'] == null
                                            ? SizedBox.fromSize()
                                            : InkWell(
                                                onTap: () {
                                                  print(
                                                      'UserID 00 ${APiUrl.imagePath}${datamsg[index]["img${datamsg[index]['userId'][0]}"]}');
                                                  print(
                                                      'UserID 11 "${APiUrl.imagePath}${datamsg[index]["img${datamsg[index]['userId'][1]}"]}" ');
                                                  Get.find<CharController>()
                                                      .updateUserId(
                                                          datamsg[index]
                                                              ['userId']);
                                                  Get.to(() => UserChatWidget(
                                                        docId: dataId[index]
                                                            .toString(),
                                                        userName: appStorage
                                                                    .read(
                                                                        USERID)
                                                                    .toString() ==
                                                                datamsg[index][
                                                                        'userId'][0]
                                                                    .toString()
                                                            ? "${datamsg[index]["${datamsg[index]['userId'][1]}"]}"
                                                            : "${datamsg[index]["${datamsg[index]['userId'][0]}"]}",
                                                        otherImg: appStorage
                                                                    .read(
                                                                        USERID)
                                                                    .toString() ==
                                                                datamsg[index][
                                                                            'userId']
                                                                        [0]
                                                                    .toString()
                                                            ? "${datamsg[index]["img${datamsg[index]['userId'][1]}"]}" ==
                                                                    "default.png"
                                                                ? "${APiUrl.imgProfile}"
                                                                : "${APiUrl.imagePath}${datamsg[index]["img${datamsg[index]['userId'][1]}"]}"
                                                            : "${APiUrl.imagePath}${datamsg[index]["img${datamsg[index]['userId'][0]}"]}",
                                                      ));
                                                },
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 15),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .blackShade),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 20,
                                                          backgroundImage: NetworkImage(appStorage
                                                                      .read(
                                                                          USERID)
                                                                      .toString() ==
                                                                  datamsg[index]
                                                                              [
                                                                              'userId']
                                                                          [0]
                                                                      .toString()
                                                              ? "${datamsg[index]["img${datamsg[index]['userId'][1]}"]}" ==
                                                                      "default.png"
                                                                  ? "${APiUrl.imgProfile}"
                                                                  : "${APiUrl.imagePath}${datamsg[index]["img${datamsg[index]['userId'][1]}"]}"
                                                              : "${APiUrl.imagePath}${datamsg[index]["img${datamsg[index]['userId'][0]}"]}"),
                                                        ),
                                                        horizental(10),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.65,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              boldtext(
                                                                  AppColors
                                                                      .black,
                                                                  13,
                                                                  appStorage.read(USERID).toString() ==
                                                                          datamsg[index]['userId'][0]
                                                                              .toString()
                                                                      ? "${datamsg[index]["${datamsg[index]['userId'][1]}"]}"
                                                                      : "${datamsg[index]["${datamsg[index]['userId'][0]}"]}"),
                                                              mediumtext(
                                                                  AppColors
                                                                      .blackShade,
                                                                  11,
                                                                  "${datamsg[index]['msg']}")
                                                            ],
                                                          ),
                                                        ),
                                                        CircleAvatar(
                                                          // radius: 15,
                                                          backgroundColor:
                                                              AppColors.black,
                                                          child: IconButton(
                                                              onPressed:
                                                                  () async {
                                                                print(dataId[
                                                                    index]);
                                                                showLoadingDialog();
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'chats')
                                                                    .doc(dataId[
                                                                        index])
                                                                    .delete();
                                                                Get.back();
                                                              },
                                                              icon: Image.asset(
                                                                  AppImages
                                                                      .delete_icon)),
                                                        ),
                                                      ],
                                                    )),
                                              );
                                      }));
                        }
                    }
                  }),
              const Padding(
                padding: EdgeInsets.only(bottom: 30, left: 20),
                child: Align(
                    alignment: Alignment.bottomLeft, child: CustomBackButton()),
              ),
            ],
          )),
    );
  }
}
