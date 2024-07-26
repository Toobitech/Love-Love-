import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/controller/user_controller.dart';

import '../component/custom_button.dart';
import '../component/snackbar.dart';
import '../helper/colors.dart';
import '../helper/const_text.dart';

class SetPriceDialog extends StatefulWidget {
  final int? id;
  final String? mint;
  final String? amount;

  SetPriceDialog({this.id, this.mint, this.amount});

  @override
  _SetPriceDialogState createState() => _SetPriceDialogState();
}

class _SetPriceDialogState extends State<SetPriceDialog> {
  final controller = Get.put(UserController());
  String? pricing;

  TextEditingController textFieldController2 = TextEditingController();
  List<String> pricingType = [
    "15",
    "30",
    "45",
  ];
  @override
  void initState() {
    super.initState();
    // Initialize the genderName and textFieldController2 with the provided values
    // pricing = widget.mint;
    textFieldController2.text = widget.amount ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      icon: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.close, color: AppColors.pink),
        ),
      ),
      title: Center(
        child: Container(
          width: 160,
          child: const Text(
            'Add Your Price',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: boldtext(AppColors.blackShade, 14, 'Time Duration')),
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.grey, width: 1.0)),
              child: DropdownButton(
                isExpanded: true,
                value: pricing ?? pricingType.first,
                hint: Text(
                  "Select Pricing",
                  style: TextStyle(fontSize: 12),
                ),
                items: pricingType.map((price) {
                  return DropdownMenuItem(
                    value: price,
                    child: Text(
                      price,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ), //value of item
                  );
                }).toList(),
                onChanged: (value) {
                  pricing = value;
                  setState(() {});
                },
                underline: Container(),
              ),
            ),
            // Container(
            //   height: 40,
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(30.0),
            //       border: Border.all(color: Colors.grey, width: 1.0)),
            //   child: DropdownButton(
            //     isExpanded: true,
            //     value: pricing,
            //     hint: Text(
            //       "Select Pricing",
            //       style: TextStyle(fontSize: 12),
            //     ),
            //     items: pricingType.map((price) {
            //       return DropdownMenuItem(
            //         value: price,
            //         child: Text(
            //           price,
            //           style: TextStyle(
            //               fontSize: 12, fontWeight: FontWeight.w600),
            //         ), //value of item
            //       );
            //     }).toList(),
            //     onChanged: (value) {
            //       // pricing = value;
            //       setState(() {
            //         pricing = value.toString();
            //         print('Selected pricing: $pricing');
            //         // print('objectahhhhhhhhhhhhhhhhhhhhhhhh');
            //         // print(pricing);
            //       });
            //     },
            //     underline: Container(),
            //   ),
            // ),

            // CustomTextFiled(textFieldController1, 'Enter Time Duration'),
            const SizedBox(height: 12),
            CustomTextFiled(textFieldController2, 'Set Your Price')
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomButton(
            title: 'Confirm',
            tap: () {
              if (pricing!.isNotEmpty && textFieldController2.text.isNotEmpty) {
                if (widget.id != null) {
                  print(widget.id!);
                  print(widget.id);
                  print(textFieldController2.text);
                  Get.back();
                  controller.editPricingVal(widget.id!, pricing.toString(),
                      textFieldController2.text);
                } else {
                  Get.back();
                  // if (controller.princinglist.length <= 3) {
                  controller.postAddPricing(
                      pricing.toString(), textFieldController2.text);
                  // } else {
                  //   showInSnackBar('Not Allow More 3 Items', color: Colors.red);
                  // }
                }
              } else {
                showInSnackBar('Please Enter Complete Detail',
                    color: Colors.red);
              }
            },
          ),
        )
      ],
    );
  }

  Widget CustomTextFiled(TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
          child: boldtext(AppColors.blackShade, 14, hint),
        ),
        SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              hintText: hint,
            ),
          ),
        ),
      ],
    );
  }
}
