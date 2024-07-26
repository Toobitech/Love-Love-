import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:prolovelove/component/api_url.dart';

import 'package:intl/intl.dart';
import '../component/bottomsmallStyle.dart';
import '../component/custom_backbutton.dart';
import '../helper/colors.dart';
import '../helper/spacer.dart';
import 'controller/user_controller.dart';
import 'model/call_logdata_model.dart';

class CallLogsScreen extends StatefulWidget {
  const CallLogsScreen({super.key});

  @override
  State<CallLogsScreen> createState() => _CallLogsScreenState();
}

class _CallLogsScreenState extends State<CallLogsScreen> {
  final controller = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    controller.getCallLogs();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.getCallLogs();
      },
      child: Scaffold(
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
          botom: false,
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 35),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomBackButton(),
                ),
              ),
              vertical(70),
              Center(
                child: Text(
                  'Call Logs',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.063,
                      fontWeight: FontWeight.w900),
                ),
              ),
              vertical(10),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: boldtext(AppColors.black, 23, 'Today')),
              // ),
              Obx(() => Expanded(
                    child: controller.clogsisLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.pink,
                            ),
                          )
                        : controller.callLogslist.isEmpty
                            ? const Center(
                                child: Text('list is Empty...'),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ListView.builder(
                                    itemCount: controller.callLogslist.length,
                                    reverse: true,
                                    itemBuilder: (context, index) {
                                      DataCallLogsModel item =
                                          controller.callLogslist[index];

                                      // Format the date
                                      String formattedDate =
                                          formatDate(item.createdAt);

                                      print(
                                          'formattedDATeTIme ${formattedDate}'); // Output: Fri, 18 Dec, 2023

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              margin: const EdgeInsets.only(
                                                  right: 15),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 2),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 10,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                  image: DecorationImage(
                                                      image: NetworkImage(APiUrl
                                                              .imagePath +
                                                          "public/" +
                                                          item.professionUser
                                                              .profile),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    if (item.callType ==
                                                        'missed')
                                                      Image.asset(
                                                        'assets/images/icons/decliend_call.png',
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    if (item.callType == 'dial')
                                                      Image.asset(
                                                        'assets/images/icons/dailing_call.png',
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    if (item.callType ==
                                                        'receive')
                                                      Image.asset(
                                                        'assets/images/icons/accept_call.png',
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    Text(
                                                      item.professionUser
                                                          .firstName,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color:
                                                              AppColors.black),
                                                    )
                                                  ],
                                                ),
                                                vertical(5),
                                                if (item.callType == 'receive')
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'received call ${item.timeDuration} minutes',
                                                        style: const TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Text(
                                                        formattedDate,
                                                        style: const TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                if (item.callType == 'missed')
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'missed call ${item.timeDuration} minutes',
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Text(
                                                        formattedDate,
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                if (item.callType == 'dial')
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'dial ${item.timeDuration} / remaining ${item.remainingTime} mint',
                                                        style: const TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        formattedDate,
                                                        style: const TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                  ))

              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     child: ListView.builder(
              //         itemCount: 10,
              //         itemBuilder: (context, index) {
              //           return Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Row(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Container(
              //                   height: 80,
              //                   width: 80,
              //                   margin: const EdgeInsets.only(right: 15),
              //                   decoration: BoxDecoration(
              //                       shape: BoxShape.circle,
              //                       border:
              //                           Border.all(color: Colors.red, width: 3),
              //                       boxShadow: [
              //                         BoxShadow(
              //                           color: Colors.red.withOpacity(
              //                               0.5), // Adjust the color and opacity for the glow effect
              //                           spreadRadius: 2,
              //                           blurRadius: 10,
              //                           offset: const Offset(0,
              //                               0), // Adjust the offset to control the shadow direction
              //                         ),
              //                       ],
              //                       image: const DecorationImage(
              //                           image: NetworkImage(APiUrl.defaultImage),
              //                           fit: BoxFit.cover)),
              //                 ),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Row(
              //                       children: [
              //                         Image.asset(
              //                           'assets/images/icons/decliend_call.png',
              //                           height: 40,
              //                           width: 40,
              //                         ),
              //                         Text(
              //                           'Aleyia cly',
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 20,
              //                               color: AppColors.black),
              //                         )
              //                       ],
              //                     ),
              //                     vertical(5),
              //                     RichText(
              //                       text: const TextSpan(
              //                         text: 'miss call 3 minutes ago ',
              //                         style: TextStyle(
              //                           color: Colors.red,
              //                           fontSize: 12,
              //                           fontWeight: FontWeight.normal,
              //                         ),
              //                         children: <TextSpan>[
              //                           TextSpan(
              //                             text: 'Fri, 12 Dec, 2023',
              //                             style: TextStyle(
              //                               color: Colors.red,
              //                               fontSize: 12,
              //                               fontWeight: FontWeight.normal,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                   ],
              //                 )
              //               ],
              //             ),
              //           );
              //         }),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('E, d MMM, y');
    return formatter.format(dateTime);
  }
}
