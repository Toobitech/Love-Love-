import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:prolovelove/controller/api_service.dart';
import 'package:prolovelove/model/profession_catetory_model.dart';
import '../component/alertboxes.dart';
import '../component/api_url.dart';
import '../component/globalvariables.dart';
import '../component/snackbar.dart';
import '../model/MyProfileModel.dart';
import '../model/call_logdata_model.dart';
import '../model/datetime_model.dart';
import '../model/pricing_model.dart';
import '../model/user_model.dart';
import '../model/withdraw_model.dart';
import '../view/user_mian_screen.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool clrisLoading = false.obs;
  RxBool clogsisLoading = false.obs;
  RxBool bkisLoading = false.obs;
  RxBool prisLoading = false.obs;
  Rx<TimeOfDay> endtime = TimeOfDay.now().obs;
  Rx<TimeOfDay> starttime = TimeOfDay.now().obs;
  Rx<UserModel> loginUserData = UserModel().obs;
  RxList<DateTime> selectedDates = <DateTime>[].obs;
  RxList<DateTimeModel> postDatesTime = <DateTimeModel>[].obs;
  RxList<DateTimeModel> selectedDatesTime = <DateTimeModel>[].obs;
  RxList<PricingModel> princinglist = <PricingModel>[].obs;

  RxList<DataCallLogsModel> callLogslist = <DataCallLogsModel>[].obs;

  Rx<WithdrawModel> bankDetail = WithdrawModel().obs;

  RxList<ProfessionCategory> professionCatList = <ProfessionCategory>[].obs;

  Rx<File?> imageFile = Rx<File?>(null);

  Future<void> pickImage() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  getCallLogs() async {
    try {
      clogsisLoading.value = true;

      var serverResponse = await ApiService.getCallLogs();
      print("Get Call Logs ServerResponse ${serverResponse.toString()}");

      callLogslist.value = serverResponse;
      print('Call Logs ServerData $selectedDatesTime');
      clogsisLoading.value = false;
    } catch (e) {
      clogsisLoading.value = false;
      print('get Call Logs Error: $e');
    }
  }

  getProfessionCateory() async {
    try {
      var serverResponse = await ApiService.getProfessionCateory();
      log("ServerResponse ${serverResponse.toString()}");
      professionCatList.value = serverResponse;
    } catch (e) {
      log('Profession Value : $e');
    }
  }

  getPricingDetail() async {
    try {
      prisLoading.value = true;
      var serverResponse = await ApiService.getPrcingDetail();
      log("ServerResponse Pricing ${serverResponse.toString()}");
      princinglist.value = serverResponse;
      prisLoading.value = false;
    } catch (e) {
      log('Pricing Model Value : $e');
    } finally {
      prisLoading.value = false;
    }
  }

  deletePricingDetail(int id) async {
    try {
      // showLoadingDialog();
      // prisLoading.value = true;
      var res = ApiService.deletePricingDetail(id);
      getPricingDetail();
      // prisLoading.value = false;
      // if (res != null) {
      //   // showLoadingDialog();
      //   getPricingDetail();
      //   // hideLoadingDialog();
      // }
    } catch (e) {
      print('Delete Calander Error: $e');
    } finally {
      // hideLoadingDialog();
      prisLoading.value = false;
    }
  }

  editPricingVal(int id, String mints, String amount) async {
    try {
      // prisLoading.value = true;
      var res = ApiService.editPricingVal(id, mints, amount);
      getPricingDetail();
      // prisLoading.value = false;
      // if (res != null) {
      //   getPricingDetail();
      // }
    } catch (e) {
      print('Edit Pricing Error: $e');
    } finally {
      // prisLoading.value = false;
    }
  }

  getUserData() async {
    try {
      isLoading.value = true;
      var serverResponse = await ApiService.getUserData();
      print("ServerResponse ${serverResponse.toString()}");

      loginUserData.value = UserModel.fromJson(serverResponse);
      // print('UserServerData ${loginUserData.value.profession}');
      isLoading.value = false;
    } catch (e) {
      // isLoading.value = false;
      print('UserDataError: $e');
    } finally {
      isLoading.value = false;
    }
  }

  postCalender(List<DateTimeModel> calender) async {
    try {
      // isLoading.value = true;
      var serverResponse = await ApiService.postCalenderData(calender);
      // print("ServerResponse ${serverResponse.toString()}");

      // loginUserData.value = UserModel.fromJson(serverResponse);
      // print('UserServerData ${loginUserData.value.profession}');
      // isLoading.value = false;
    } catch (e) {
      // isLoading.value = false;
      print('Post Calander Error: $e');
    }
  }

  getBankDetaul() async {
    try {
      bkisLoading.value = true;
      var serverResponse = await ApiService.getBankDetail();
      print("ServerResponse ${serverResponse.toString()}");

      bankDetail.value = WithdrawModel.fromJson(serverResponse);
      print('Bank Detail ServerData ${bankDetail.value.bankName}');
      bkisLoading.value = false;
    } catch (e) {
      print('Bank Detail Error: $e');
    } finally {
      bkisLoading.value = false;
    }
  }

  withdrawAmount(WithdrawModel data) async {
    try {
      // isLoading.value = true;
      var serverResponse = await ApiService.withdrawAmount(data);
      // print("ServerResponse ${serverResponse.toString()}");

      // loginUserData.value = UserModel.fromJson(serverResponse);
      // print('UserServerData ${loginUserData.value.profession}');
      // isLoading.value = false;
    } catch (e) {
      // isLoading.value = false;
      print('Withdraw Amount Error: $e');
    }
  }

  postAddPricing(String mints, String amount) {
    try {
      // isLoading.value = true;
      var serverResponse = ApiService.postAddPricing(mints, amount);
      print('object1231231223123123');
      print(serverResponse);
      if (serverResponse != null) {
        print('dajaskdkashdkah');
        // Get.back();
        // showLoadingDialog();
        getPricingDetail();
        // hideLoadingDialog();
      }
    } catch (e) {
      // isLoading.value = false;
      print('Post Pricing Error: $e');
    }
  }

  deleteCalender(int id) async {
    try {
      clrisLoading.value = true;
      await ApiService.deleteCalenderData(id);
      clrisLoading.value = false;
    } catch (e) {
      clrisLoading.value = false;
      print('Delete Calander Error: $e');
    }
  }

  getCalender(String date) async {
    try {
      clrisLoading.value = true;
      print(date);
      var serverResponse = await ApiService.getCalenderData(date);
      print("Get Calender ServerResponse ${serverResponse.toString()}");

      selectedDatesTime.value = serverResponse;
      print('CalenderServerData $selectedDatesTime');
      clrisLoading.value = false;
    } catch (e) {
      clrisLoading.value = false;
      print('get Celander Error: $e');
    }
  }

  changeUserStatus(int val) async {
    try {
      var serverResponse = await ApiService.changeUserStatus(val);
      print("ServerResponse ${serverResponse.toString()}");
      print("ServerResponseIslogin ${serverResponse['is_login']}");

      loginUserData.value
          .updateIsLogin(int.parse("${serverResponse['is_login']}"));
    } catch (e) {
      print('UserStatusError: $e');
    }
  }

//
  updataProfile(UserModel userData) async {
    showLoadingDialog();
    try {
      FormData formData;
      if (userData.profileImage != null) {
        formData = FormData.fromMap({
          'first_name': userData.firstName,
          'last_name': userData.lastName,
          'age': userData.age,
          // 'education': userData.education,
          'gender': userData.gender,
          'about': userData.description,
          'professional_id': userData.professionalId,
          'profile': await MultipartFile.fromFile(userData.profileImage!),
        });
      } else {
        formData = FormData.fromMap({
          'first_name': userData.firstName,
          'last_name': userData.lastName,
          'age': userData.age,
          // 'education': userData.education,
          'gender': userData.gender,
          'about': userData.description,
          'professional_id': userData.professionalId,
        });
      }
      var response = await dio.post(APiUrl.updateProfile,
          options: Options(headers: {
            'Authorization': "Bearer  $userToken ",
          }),
          data: formData);
      print('Status Code ${response.statusCode}');

      print('Response Data ${response.data}');
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data['success'] == true) {
          showInSnackBar(response.data['message'], color: Colors.green);
          print('UpdateDataStore $loginUserData');

          print('UserModel Data ${loginUserData.value.firstName}');
          final responseData = response.data;
          hideLoadingDialog();

          Get.to(UserMainScreen());
        } else {
          print(response.data);
          showInSnackBar(response.data['message'], color: Colors.red);
          print('UpdateDataStore $loginUserData');

          print('UserModel Data ${loginUserData.value.firstName}');
          final responseData = response.data;
          hideLoadingDialog();
        }
        // UserModel data = UserModel(
        //     firstName: response.data['first_name'],
        //     lastName: response.data['last_name'],
        //     age: response.data['age'].toString(),
        //     education: response.data['education'],
        //     gender: response.data['gender'],
        //     description: response.data['about'],
        //     profileImage: null,
        //     professionalId: int.parse(response.data['professional_id']));
        // loginUserData.value = data;
      }
    } catch (e) {
      print('Update Profile Errorr  $e');
    }
  }
}
//new kamlesh
// dynamic sendProfileData(
//   Map<String, dynamic> profiledata3,
// ) async {
//   showLoadingDialog();
//   print('profiledata3 $profiledata3');

//   try {
//     var response = await http.post(Uri.parse(AppUrl.profileURL),
//         headers: {
//           'Authorization': "Bearer  $userToken ",
//           'Accept': "application/json"
//         },
//         body: profiledata3);

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = jsonDecode(response.body);
//       print(response.body);
//       print('$profiledata3');

//       if (data["success"] == true) {
//         hideLoadingDialog();
//         if (appStorage.read(ACCOUNT_FOR) == '1' &&
//             myprofileIncontroller.UserDataList?.phone == null) {
//           print(myprofileIncontroller.UserDataList?.phone);
//           Get.to(() => verify_number());
//         } else {
//           Get.to(() => UploadPicture());
//         }
//       } else {
//         hideLoadingDialog();
//         showInSnackBar(data['Message'], color: Colors.red);
//       }
//     }

//     print(response.statusCode);
//   } catch (e) {
//     hideLoadingDialog();
//     showInSnackBar('Server Issue', color: Colors.red);
//     print(e.toString());
//   }
// }

// class MedicalConditionController extends GetxController {
//   List<MedicalData1> MedicalConditionList1 = [];
//   List<MedicalData2> MedicalConditionList2 = [];
//   var isLoading = false.obs;

//   fetchMedicalCondition() async {
//     isLoading.value = true;

//     try {
//       final response = await http.get(
//         Uri.parse('${AppUrl.medicalURL}'),
//         headers: {
//           'Authorization': "Bearer  $userToken ",
//           'Accept': "application/json"
//         },
//       );
//       if (response.statusCode == 200) {
//         print(response.body);
//         MedicalConditionModel data1234 =
//             MedicalConditionModel.fromJson(jsonDecode(response.body));
//         MedicalConditionList1 = data1234.data1;
//         MedicalConditionList2 = data1234.data2;
//         // print(MedicalConditionList);

//         isLoading.value = false;
//       }
//     } catch (e) {
//       isLoading.value = false;
//       print(e.toString());
//     }
//   }

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     // fetchUserId();
//   }
// }

// class InterestController extends GetxController {
//   List<InterestData> InterestList = [];
//   List<String> selected = [];
//   addListValues(List<String> value) {
//     selected = value;
//   }

//   emptySelected() {
//     selected = [];
//   }

//   var isLoading = false.obs;

//   fetchInterestData() async {
//     isLoading.value = true;

//     try {
//       final response = await http.get(
//         Uri.parse('${AppUrl.interestURL}'),
//         headers: {
//           'Authorization': "Bearer  $userToken ",
//           'Accept': "application/json"
//         },
//       );
//       if (response.statusCode == 200) {
//         print(response.body);
//         print("intrest----------------------------------------------------");
//         InterestModel data678 =
//             InterestModel.fromJson(jsonDecode(response.body));
//         InterestList = data678.data;

//         // print(MedicalConditionList);

//         isLoading.value = false;
//       }
//     } catch (e) {
//       isLoading.value = false;
//       print(e.toString());
//     }
//   }

class MyProfileController extends GetxController {
  UserModelData? userDataList;

  var isLoading = false.obs;

  fetchUserData() async {
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse(APiUrl.loginURL),
        headers: {
          'Authorization': "Bearer  $userToken ",
          'Accept': "application/json"
        },
      );
      if (response.statusCode == 200) {
        log(response.body);
        MyProfileModel data98 =
            MyProfileModel.fromJson(jsonDecode(response.body));
        userDataList = data98.data;
        log(userDataList.toString());

        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      log("error in my profile $e");
    }
  }
}
