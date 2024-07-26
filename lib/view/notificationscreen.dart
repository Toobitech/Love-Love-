import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/bottomsmallStyle.dart';
import '../component/card_widget.dart';
import '../component/custom_backbutton.dart';
import '../controller/notification_controller.dart';
import '../helper/colors.dart';
import '../helper/const_text.dart';
import '../helper/spacer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notifycontroller = Get.put(NotificationController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifycontroller.fetchNotificationData();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<NotificationController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: CustomBackButton(),
        ),
        body: BottomSmallStyle(
          topHeight: 0.23,
          body: notifycontroller.isLoading.value == true
              ? SizedBox(
                  height: Get.height * 0.7,
                  width: Get.width,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          color: AppColors.pink,
                        )),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    top: 70,
                  ),
                  child: Column(
                    children: [
                      vertical(100),

                      Center(
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.063,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      vertical(10),
                      SizedBox(
                        height: Get.height * 0.67,
                        child: notifycontroller.notificationList.isEmpty
                            ? Center(
                                child: boldtext(
                                    Colors.grey, 14, "No Data Available"))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount:
                                    notifycontroller.notificationList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CardWidget(
                                    child: ListTile(
                                      title: mediumtext(AppColors.white, 14,
                                          "${notifycontroller.notificationList[index].description}"),
                                      trailing: mediumtext(AppColors.white, 10,
                                          "${notifycontroller.notificationList[index].createdAt.toString().split('T').first}"),
                                    ),
                                  );
                                }),
                      )

                      // )
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
