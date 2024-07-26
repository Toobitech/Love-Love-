// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/api_url.dart';
import '../../../component/bottomsmallStyle.dart';
import '../../../component/globalvariables.dart';
import '../../../helper/colors.dart';
import '../../../helper/const_text.dart';
import 'chat_message_send.dart';

class UserChatWidget extends StatelessWidget {
  String userName;
  String docId;
  String otherImg;
  UserChatWidget(
      {super.key,
      required this.userName,
      required this.docId,
      required this.otherImg});

  @override
  Widget build(BuildContext context) {
    print('$otherImg');
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.black,
              )),
          title: boldtext(AppColors.black, 18, userName),
        ),
        body: BottomSmallStyle(
          top: false,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc('$docId')
                    .collection('messages')
                    .orderBy("count", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data1 = snapshot.data?.docs;
                    var msgs =
                        snapshot.data!.docs.map((e) => e.data()).toList();

                    print(data1!.length);
                    return Column(
                      children: [
                        Expanded(
                            flex: 9,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                reverse: true,
                                padding: EdgeInsets.zero,
                                itemCount: msgs.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      chatView(
                                          "${otherImg}",
                                          "${msgs[index]['msg']}",
                                          appStorage.read(USERID) !=
                                              msgs[index]['id']),
                                    ],
                                  );
                                })),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: ChatMessageSend(
                          docId: docId,
                          count: data1.length,
                        ))
                      ],
                    );
                  }
                  return SizedBox();
                }),
          ),
        ));
  }
}

Widget chatView(String userName, String msg, bool isMe) {
  return Padding(
    padding: EdgeInsets.only(top: 10),
    child: Stack(
      children: [
        Align(
          alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
              padding:
                  EdgeInsets.fromLTRB(isMe ? 55 : 10, 10, isMe ? 10 : 55, 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              // width: Get.width * 0.9,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientLight, AppColors.gradientDark],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: mediumtext(AppColors.white, 11, msg)),
        ),
        Align(
          alignment:
              isMe == true ? Alignment.bottomLeft : Alignment.centerRight,
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(isMe != true
                ? "${APiUrl.imagePath}/${appStorage.read(profileUrl).toString()}"
                : "$userName"),
          ),
        ),
      ],
    ),
  );
}
