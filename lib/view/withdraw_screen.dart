import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/controller/user_controller.dart';
import 'package:prolovelove/model/withdraw_model.dart';
import '../component/alertboxes.dart';
import '../component/bottomsmallStyle.dart';
import '../component/custom_backbutton.dart';
import '../component/custom_button.dart';
import '../component/snackbar.dart';
import '../helper/colors.dart';
import '../helper/const_text.dart';

class WithdrawScreen extends StatefulWidget {
  WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final controller = Get.put(UserController());
  TextEditingController amountController = TextEditingController();
  TextEditingController bankNameControlller = TextEditingController();
  TextEditingController accNameController = TextEditingController();
  TextEditingController accNumberController = TextEditingController();
  TextEditingController routingNoController = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.getBankDetaul();
    bankNameControlller =
        TextEditingController(text: controller.bankDetail.value.bankName);
    accNameController =
        TextEditingController(text: controller.bankDetail.value.accName);
    accNumberController =
        TextEditingController(text: controller.bankDetail.value.accNumber);
    routingNoController =
        TextEditingController(text: controller.bankDetail.value.routingNumber);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        return showExitPopup();
      },
      child: RefreshIndicator(
        onRefresh: () async {},
        child: Scaffold(
            extendBodyBehindAppBar: true,
            // backgroundColor: AppColors.white,
            // drawer: userdrawer(
            //   userData: controller.loginUserData.value,
            // ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: CustomBackButton(),
            ),
            body: BottomSmallStyle(
              topHeight: 0.23,
              body: Obx(
                () => controller.bkisLoading.value == true
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
                    : SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                25, Get.height * 0.22, 25, 20),
                            child: Column(
                              children: [
                                // SizedBox(height: 60),
                                Center(
                                    child: Image.asset(
                                  'assets/images/icons/payment_heart.png',
                                  height: 80,
                                  width: 80,
                                )),
                                boldtext(
                                    AppColors.pink,
                                    30,
                                    controller.loginUserData.value.walletBalance
                                        .toString()),
                                regulartext(
                                  AppColors.black,
                                  12,
                                  'your Balance',
                                ),
                                CustomTextFiled(amountController,
                                    "Enter Amount", TextInputType.number),
                                CustomTextFiled(bankNameControlller,
                                    "Bank Name", TextInputType.name),
                                CustomTextFiled(accNameController,
                                    "Account Name", TextInputType.name),
                                CustomTextFiled(accNumberController,
                                    "Account Number", TextInputType.number),
                                CustomTextFiled(routingNoController,
                                    "Routing Number", TextInputType.number),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 50),
                                  child: CustomButton(
                                    title: 'Withdraw',
                                    tap: () {
                                      if (controller.loginUserData.value
                                              .walletBalance ==
                                          '0.00') {
                                        showInSnackBar("You Havn't Amount",
                                            color: Colors.red);
                                      } else if (amountController
                                          .text.isEmpty) {
                                        showInSnackBar('Please Enter Amount',
                                            color: Colors.red);
                                      } else if (bankNameControlller
                                          .text.isEmpty) {
                                        showInSnackBar('Please Enter Bank Name',
                                            color: Colors.red);
                                      } else if (accNameController
                                          .text.isEmpty) {
                                        showInSnackBar(
                                            'Please Enter Account Name',
                                            color: Colors.red);
                                      } else if (accNumberController
                                          .text.isEmpty) {
                                        showInSnackBar(
                                            'Please Enter Account Number',
                                            color: Colors.red);
                                      } else if (routingNoController
                                          .text.isEmpty) {
                                        showInSnackBar(
                                            'Please Enter Routing Number',
                                            color: Colors.red);
                                      } else {
                                        print('objectTextFiledFinal');
                                        WithdrawModel userData = WithdrawModel(
                                          amount: amountController.text,
                                          bankName: bankNameControlller.text,
                                          accName: accNameController.text,
                                          accNumber: accNumberController.text,
                                          routingNumber:
                                              routingNoController.text,
                                        );
                                        controller.withdrawAmount(userData);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )),
                      ),
              ),
            )),
      ),
    );
  }

  Widget CustomTextFiled(
      TextEditingController controller, String hint, var keyType) {
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
            keyboardType: keyType,
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
