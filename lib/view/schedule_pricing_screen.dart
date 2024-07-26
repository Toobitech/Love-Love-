import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:prolovelove/component/custom_button.dart';
import 'package:prolovelove/controller/user_controller.dart';
import 'package:prolovelove/model/pricing_model.dart';
import '../component/bottomsmallStyle.dart';
import '../component/custom_backbutton.dart';
import '../component/snackbar.dart';
import '../helper/colors.dart';
import '../helper/const_text.dart';
import '../helper/spacer.dart';
import 'pricing_alert_box.dart';

class SchedulePricingScreen extends StatefulWidget {
  const SchedulePricingScreen({super.key});

  @override
  State<SchedulePricingScreen> createState() => _SchedulePricingScreenState();
}

class _SchedulePricingScreenState extends State<SchedulePricingScreen> {
  final controller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    controller.getPricingDetail();
  }

  // String? genderName;
  // List<String> genderType = [
  //   "male",
  //   "female",
  //   "other",
  // ];

  String? pricing;
  List<String> pricingType = [
    "15",
    "30",
    "45",
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.getPricingDetail();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.pink,
          onPressed: () {
            if (controller.princinglist.length < 3) {
              setPriceDialog(context);
            } else {
              showInSnackBar('Not Allow More 3 Items', color: Colors.red);
            }
          },
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
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
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 35),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomBackButton(),
                ),
              ),
              vertical(100),
              Center(
                child: Text(
                  'Pricing',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.063,
                      fontWeight: FontWeight.w900),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Padding(
              //     padding: const EdgeInsets.all(35.0),
              //     child: FloatingActionButton(
              //       backgroundColor: AppColors.pink,
              //       onPressed: () {
              //         setPriceDialog(context);
              //       },
              //       child: Icon(
              //         Icons.add,
              //         color: AppColors.white,
              //       ),
              //     ),
              //   ),
              // ),
              vertical(30),
              // Padding(
              //   padding: const EdgeInsets.only(right: 15),
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: SizedBox(
              //       width: 100,
              //       child: CustomButton(
              //         title: 'Add New',
              //         tap: () {
              //           setPriceDialog(context);
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              Obx(() => controller.prisLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.pink,
                      ),
                    )
                  : controller.princinglist.isEmpty
                      ? const Center(
                          child: Text('List is Empty'),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: controller.princinglist.length,
                              itemBuilder: (context, index) {
                                PricingModel item =
                                    controller.princinglist[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border:
                                          Border.all(color: AppColors.pricing)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${item.mins} minutes',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '\$${item.amount}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                _showDeleteAlertDialog(
                                                    context, item.id!);
                                              },
                                              icon: const Icon(
                                                  Icons.delete_outline)),
                                          IconButton(
                                              onPressed: () {
                                                setPriceDialog(context,
                                                    id: item.id,
                                                    mint: item.mins.toString(),
                                                    amount:
                                                        item.amount.toString());
                                              },
                                              icon: const Icon(
                                                  Icons.edit_outlined))
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                        )),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteAlertDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Delete Confirmation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.pink,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.pink,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform the delete operation here
                print('Deleting...');
                Get.back();
                controller.deletePricingDetail(id);
                // Close the dialog
                // Get.back();
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: AppColors.pink,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void setPriceDialog(BuildContext context,
      {int? id, String? mint, String? amount}) {
    // TextEditingController textFieldController1 =
    //     TextEditingController(text: mint);
    // TextEditingController textFieldController2 =
    //     TextEditingController(text: amount);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SetPriceDialog(
          id: id,
          mint: mint,
          amount: amount,
        );
        // AlertDialog(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   icon: Align(
        //     alignment: Alignment.topRight,
        //     child: GestureDetector(
        //       onTap: () {
        //         Get.back();
        //       },
        //       child: Icon(Icons.close, color: AppColors.pink),
        //     ),
        //   ),
        //   title: Center(
        //     child: Container(
        //       width: 160,
        //       child: const Text(
        //         'Add Your Price',
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //             fontSize: 30,
        //             fontWeight: FontWeight.w700,
        //             color: Colors.black),
        //       ),
        //     ),
        //   ),
        //   content: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 12),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
        //           child: Align(
        //               alignment: Alignment.centerLeft,
        //               child:
        //                   boldtext(AppColors.blackShade, 14, 'Time Duration')),
        //         ),
        //         Container(
        //           height: 40,
        //           padding: const EdgeInsets.symmetric(horizontal: 10),
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(30.0),
        //               border: Border.all(color: Colors.grey, width: 1.0)),
        //           child: DropdownButton(
        //             isExpanded: true,
        //             value: genderName,
        //             hint: Text(
        //               "Select Gender",
        //               style: TextStyle(fontSize: 12),
        //             ),
        //             items: genderType.map((countryone) {
        //               return DropdownMenuItem(
        //                 value: countryone,
        //                 child: Text(
        //                   countryone,
        //                   style: TextStyle(
        //                       fontSize: 12, fontWeight: FontWeight.w600),
        //                 ), //value of item
        //               );
        //             }).toList(),
        //             onChanged: (value) {
        //               genderName = value;
        //               setState(() {});
        //             },
        //             underline: Container(),
        //           ),
        //         ),
        //         // Container(
        //         //   height: 40,
        //         //   padding: const EdgeInsets.symmetric(horizontal: 10),
        //         //   decoration: BoxDecoration(
        //         //       borderRadius: BorderRadius.circular(30.0),
        //         //       border: Border.all(color: Colors.grey, width: 1.0)),
        //         //   child: DropdownButton(
        //         //     isExpanded: true,
        //         //     value: pricing,
        //         //     hint: Text(
        //         //       "Select Pricing",
        //         //       style: TextStyle(fontSize: 12),
        //         //     ),
        //         //     items: pricingType.map((price) {
        //         //       return DropdownMenuItem(
        //         //         value: price,
        //         //         child: Text(
        //         //           price,
        //         //           style: TextStyle(
        //         //               fontSize: 12, fontWeight: FontWeight.w600),
        //         //         ), //value of item
        //         //       );
        //         //     }).toList(),
        //         //     onChanged: (value) {
        //         //       // pricing = value;
        //         //       setState(() {
        //         //         pricing = value.toString();
        //         //         print('Selected pricing: $pricing');
        //         //         // print('objectahhhhhhhhhhhhhhhhhhhhhhhh');
        //         //         // print(pricing);
        //         //       });
        //         //     },
        //         //     underline: Container(),
        //         //   ),
        //         // ),

        //         // CustomTextFiled(textFieldController1, 'Enter Time Duration'),
        //         const SizedBox(height: 12),
        //         CustomTextFiled(textFieldController2, 'Set Your Price')
        //       ],
        //     ),
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20),
        //       child: CustomButton(
        //         title: 'Confirm',
        //         tap: () {
        //           if (controller.princinglist.length < 3) {
        //             // if (textFieldController1.text.isNotEmpty &&
        //             //     textFieldController2.text.isNotEmpty) {
        //             //   if (id != null) {
        //             //     print(id);
        //             //     print(textFieldController1.text);
        //             //     print(textFieldController2.text);
        //             //     Get.back();
        //             //     controller.editPricingVal(id, textFieldController1.text,
        //             //         textFieldController2.text);
        //             //   } else {
        //             //     Get.back();
        //             //     controller.postAddPricing(textFieldController1.text,
        //             //         textFieldController2.text);
        //             //   }
        //             // } else {
        //             //   showInSnackBar('Please Enter Complete Detail',
        //             //       color: Colors.red);
        //             // }
        //           } else {
        //             showInSnackBar('Not Allow More 3 Items', color: Colors.red);
        //           }
        //         },
        //       ),
        //     )
        //   ],
        // );
      },
    );
  }

  // Widget CustomTextFiled(TextEditingController controller, String hint) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
  //         child: boldtext(AppColors.blackShade, 14, hint),
  //       ),
  //       SizedBox(
  //         height: 40,
  //         child: TextField(
  //           controller: controller,
  //           style: const TextStyle(fontSize: 12),
  //           decoration: InputDecoration(
  //             contentPadding: const EdgeInsets.only(left: 20),
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(30.0),
  //               borderSide: const BorderSide(color: Colors.grey, width: 1.0),
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(30.0),
  //               borderSide: const BorderSide(color: Colors.grey, width: 1.0),
  //             ),
  //             hintText: hint,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
