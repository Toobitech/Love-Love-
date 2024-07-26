import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/controller/user_controller.dart';
import 'package:prolovelove/helper/colors.dart';
import '../call_logs_screen.dart';
import '../helper/assets.dart';
import '../model/user_model.dart';
import '../view/calender_show.dart';
import '../view/edit_profile_form.dart';
import '../view/privcy_policy.dart';
import '../view/schedule_pricing_screen.dart';
import '../view/withdraw_screen.dart';
import 'alertboxes.dart';

class userdrawer extends StatefulWidget {
  UserModel? userData;
  userdrawer({super.key, this.userData});

  @override
  State<userdrawer> createState() => _userdrawerState();
}

class _userdrawerState extends State<userdrawer> {
  // String selectedID = '';
  int selectedRadioTile2 = 0;
  RxBool drawer = false.obs;
  final controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      width: Get.width * 0.5,
      elevation: 0,
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: Image.asset(
                    AppImages.support,
                    width: 25,
                  ),
                  title: Text("Status",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black)),
                  onTap: () {
                    drawer.value = !drawer.value;
                  },
                  trailing: Icon(Icons.arrow_drop_down),
                ),
              ),
              Obx(() => drawer.value
                  ? Column(
                      children: [
                        Container(
                            color: Colors.white,
                            child: RadioListTile(
                                activeColor: AppColors.pink,
                                title: Text('online'),
                                value: 1,
                                groupValue: controller
                                        .loginUserData.value.isLogin?.value ??
                                    0,
                                onChanged: (value) {
                                  controller.changeUserStatus(1);
                                })),
                        Container(
                            color: Colors.white,
                            child: RadioListTile(
                                activeColor: AppColors.pink,
                                title: Text('offline'),
                                value: 0,
                                groupValue: controller
                                        .loginUserData.value.isLogin?.value ??
                                    0,
                                onChanged: (value) {
                                  controller.changeUserStatus(0);
                                })),
                      ],
                    )
                  : SizedBox()),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: Image.asset(
                    AppImages.edit_profile,
                    width: 25,
                  ),
                  title: Text("Edit Profile",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black)),
                  onTap: () {
                    //new kamlesh
                    Get.to(() => EditProfileForm(
                          userData: widget.userData!,
                          backbuttonIs: true,
                        ));
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: Image.asset(
                    AppImages.chatLove,
                    width: 25,
                  ),
                  title: Text("Calender",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black)),
                  onTap: () async {
                    print('Open Calender');
                    Get.back();
                    await showDialog(
                      context: context,
                      builder: (context) => CalendarDialogShow(),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Image.asset(
                    AppImages.privacy_policy,
                    width: 25,
                  ),
                  title: Text("Pricing Schedule",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black)),
                  onTap: () {
                    Get.to(() => SchedulePricingScreen());
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Image.asset(
                    AppImages.withdraw_policy,
                    width: 25,
                  ),
                  title: Text("Withdraw",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black)),
                  onTap: () {
                    Get.to(() => WithdrawScreen());
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Image.asset(
                    AppImages.call_icon,
                    color: AppColors.black,
                    width: 20,
                  ),
                  title: Text("Call Logs",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black)),
                  onTap: () {
                    Get.to(() => const CallLogsScreen());
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Image.asset(
                    AppImages.privacy_policy,
                    width: 25,
                  ),
                  title: Text("Privacy Policy",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black)),
                  onTap: () {
                    Get.to(() => PrivacyPolicyScreen());
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(30))),
                child: ListTile(
                  leading: Image.asset(
                    AppImages.logout,
                    width: 25,
                  ),
                  title: Text("Logout",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black)),
                  onTap: () {
                    showLogoutPopup();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
