// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/component/api_url.dart';
import 'package:prolovelove/model/user_model.dart';
import 'package:prolovelove/view/user_mian_screen.dart';
import '../component/bottomsmallStyle.dart';
import '../component/snackbar.dart';
import '../controller/user_controller.dart';
import '../helper/button.dart';
import '../helper/colors.dart';
import '../helper/const_text.dart';
import '../helper/spacer.dart';

class EditProfileForm extends StatefulWidget {
  bool backbuttonIs;
  UserModel userData;
  EditProfileForm(
      {super.key, required this.userData, this.backbuttonIs = false});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late TextEditingController firstnameController;
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController ageController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

  final usercontroller = Get.put(UserController());
  String? professionType;
  int? selectedCategoryId;
  String? genderName;
  List<String> genderType = [
    "male",
    "female",
    "other",
  ];

  @override
  void initState() {
    super.initState();
    usercontroller.getProfessionCateory();
    firstnameController = TextEditingController(
        text:
            widget.userData.firstName == null ? '' : widget.userData.firstName);
    lastNameController = TextEditingController(
        text: widget.userData.lastName == null ? '' : widget.userData.lastName);
    ageController = TextEditingController(
        text:
            widget.userData.age == null ? '' : widget.userData.age.toString());
    descriptionController = TextEditingController(
        text: widget.userData.description == null
            ? ''
            : widget.userData.description);
    // educationController = TextEditingController(
    //     text:
    //         widget.userData.education == null ? '' : widget.userData.education);
    selectedCategoryId = widget.userData.professionalId == null
        ? 0
        : widget.userData.professionalId!;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userData.gender);
    return WillPopScope(
      onWillPop: () async {
        if (widget.backbuttonIs == true) Get.to(() => UserMainScreen());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: BottomSmallStyle(
            top: false,
            body: SizedBox(
              width: Get.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      vertical(12),
                      widget.backbuttonIs
                          ? Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    if (widget.backbuttonIs == true) Get.back();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)),
                            )
                          : SizedBox(
                              height: 20,
                            ),

                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            usercontroller.pickImage();
                          },
                          child: CircleAvatar(
                            radius: 58,
                            backgroundColor: AppColors.pink,
                            child: Obx(
                              () => usercontroller.imageFile.value != null
                                  ? CircleAvatar(
                                      backgroundColor: AppColors.black,
                                      radius: 55,
                                      backgroundImage: usercontroller
                                                  .imageFile.value !=
                                              null
                                          ? FileImage(
                                              usercontroller.imageFile.value!)
                                          : null,
                                    )
                                  : Container(
                                      height: 120,
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.gradientLight,
                                              width: 2),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                widget.userData.profileImage !=
                                                        null
                                                    ? APiUrl.imagePath +
                                                        widget.userData
                                                            .profileImage
                                                            .toString()
                                                    : APiUrl.defaultImage,
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                            ),
                          ),
                        ),
                      ),

                      CustomTextFiled(firstnameController, "First Name"),
                      CustomTextFiled(lastNameController, "Last Name"),
                      CustomTextFiled(ageController, "Age"),
                      // CustomTextFiled(educationController, "Education"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child:
                                boldtext(AppColors.blackShade, 14, 'Gender')),
                      ),
                      Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(color: Colors.grey, width: 1.0)),
                        child: DropdownButton(
                          isExpanded: true,
                          value: genderName,
                          hint: Text(
                            widget.userData.gender ?? "Select Gender",
                            style: TextStyle(fontSize: 12),
                          ),
                          items: genderType.map((countryone) {
                            return DropdownMenuItem(
                              value: countryone,
                              child: Text(
                                countryone,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ), //value of item
                            );
                          }).toList(),
                          onChanged: (value) {
                            genderName = value;
                            setState(() {});
                          },
                          underline: Container(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: boldtext(
                                AppColors.blackShade, 14, 'Profession')),
                      ),
                      // Align(
                      //     alignment: Alignment.centerLeft,
                      //     child:
                      //         boldtext(AppColors.blackShade, 14, 'Profession')),
                      Obx(
                        () => Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: professionType,
                            hint: Text(
                              widget.userData.profession ?? "Select Category",
                              style: TextStyle(fontSize: 12),
                            ),
                            items: usercontroller.professionCatList
                                .map((category) {
                              return DropdownMenuItem<String>(
                                value: category.name,
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              final selectedCategory =
                                  usercontroller.professionCatList.firstWhere(
                                      (category) => category.name == value);

                              setState(() {
                                professionType = value;
                                selectedCategoryId = selectedCategory.id;
                                print(selectedCategoryId);
                              });
                            },
                            underline: Container(),
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                            child: boldtext(
                                AppColors.blackShade, 14, 'Description'),
                          ),
                          SizedBox(
                            height: 110,
                            child: TextField(
                              controller: descriptionController,
                              maxLines: 8,
                              style: const TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 15, top: 15, bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                hintText: 'Enter Something....',
                              ),
                            ),
                          ),
                        ],
                      ),

                      vertical(20),

                      buttonMain(0.6, "Submit", () {
                        if (firstnameController.text.isEmpty) {
                          showInSnackBar('Please Enter First Name',
                              color: Colors.red);
                        } else if (lastNameController.text.isEmpty) {
                          showInSnackBar('Please Enter Last Name',
                              color: Colors.red);
                        } else if (ageController.text.isEmpty) {
                          showInSnackBar('Please Enter Age', color: Colors.red);
                          // } else if (educationController.text.isEmpty) {
                          //   showInSnackBar('Please Enter Education',
                          //       color: Colors.red);
                        } else if (descriptionController.text.isEmpty) {
                          showInSnackBar('Please Enter Description',
                              color: Colors.red);
                        } else if (widget.userData.gender == null &&
                            genderName == null) {
                          showInSnackBar('Please Select Gender',
                              color: Colors.red);
                        } else if (selectedCategoryId == null &&
                            selectedCategoryId == 0) {
                          showInSnackBar('Please Select Profession',
                              color: Colors.red);
                        } else {
                          print('objectTextFiledFinal');
                          usercontroller.updataProfile(UserModel(
                              firstName: firstnameController.text,
                              lastName: lastNameController.text,
                              age: ageController.text,
                              // education: educationController.text,
                              gender: widget.userData.gender == null
                                  ? genderName
                                  : widget.userData.gender,
                              description: descriptionController.text,
                              professionalId: selectedCategoryId,
                              profileImage:
                                  usercontroller.imageFile!.value?.path));
                        }
                      },
                          bgColor: Colors.transparent,
                          bColor: AppColors.black,
                          tColor: AppColors.black),
                      vertical(10),
                      // Align(
                      //   alignment: Alignment.bottomLeft,
                      //   child: IconButton(
                      //       onPressed: () {
                      //         Get.back();
                      //       },
                      //       icon: Icon(
                      //         Icons.arrow_back_ios,
                      //         color: AppColors.black,
                      //       )),
                      // ),
                    ],
                  ),
                ),
              ),
            )),
      ),
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
