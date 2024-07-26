import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prolovelove/model/user_model.dart';
import 'package:prolovelove/view/approval.dart';
import 'package:prolovelove/view/edit_profile_form.dart';
import 'package:prolovelove/view/welcomescreen.dart';
import '../component/alertboxes.dart';
import '../component/api_url.dart';
import '../component/globalvariables.dart';
import '../component/snackbar.dart';
import '../view/call/calling_service.dart';
import '../view/forgot_auth/change_password_screen.dart';
import '../view/forgot_auth/verifycode_screen.dart';
import '../view/login_screen.dart';
import '../view/user_mian_screen.dart';

final dio = Dio();

class AuthController extends GetxController {
  RxInt matechCode = 0.obs;

  loginWithEmail(String email, String password, String deviceToken, BuildContext context) async {
  showLoadingDialog();
  try {
    var response = await dio.post(APiUrl.loginURL, data: {
      'email': email,
      'password': password,
      'device_token': deviceToken
    });

    print('statusCode ${response.statusCode}');
    if (response.statusCode == 200) {
      print("Response ${response.data}");
      final responseData = response.data;
      print("Response ${responseData["data"]}");
      print(responseData["success"]);
      if (responseData["success"] == true) {
     
        // Debug prints for status
        print("User status: ${responseData["data"]["status"]}");

        // Check status and navigate
        if (responseData["data"]["status"] == 0) {
          print("Navigating to ApprovalScreen with status true");
          hideLoadingDialog();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ApprovalScreen(status: true)),
              (route) => false);
          return; // Ensuring no further code is executed
        } else if (responseData["data"]["status"] == 2) {
          print("Navigating to ApprovalScreen with status false");
          hideLoadingDialog();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ApprovalScreen(status: false)),
              (route) => false);
          return; // Ensuring no further code is executed
        } else {
          print("Unhandled status: ${responseData["data"]["status"]}");
        }

        // Additional logic for other statuses
           appStorage.write('tokken', responseData['token']);
        appStorage.write(USERID, responseData["data"]["id"]);
        appStorage.write('professionalId', responseData["data"]["professional_id"]);
        appStorage.write('currentUserId', responseData["data"]["id"]);
        appStorage.write(userName, responseData["data"]["first_name"]);
        appStorage.write(profileUrl, responseData["data"]["profile"]);

        userId = responseData["data"]["id"].toString();
        userToken = responseData['token'];
        USERNAME = responseData["data"]["first_name"].toString();
        print(responseData["data"]["id"].toString());
        var userData = appStorage.read("currentUserId");
        print("SetUserId $userData");
        print(responseData["data"]["professional_id"]);
        if (responseData["data"]["role_id"] == "profession") {
          onUserLogin(userId.toString(), USERNAME.toString());
          if (responseData["data"]["professional_id"] != null) {
            hideLoadingDialog();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => UserMainScreen()),
                (route) => false);
          } else {
            hideLoadingDialog();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => EditProfileForm(
                          userData: UserModel(
                            id: responseData["data"]["id"],
                            firstName: responseData["data"]["first_name"],
                            lastName: responseData["data"]["last_name"],
                            age: responseData["data"]["age"].toString(),
                            gender: responseData["data"]["gender"],
                            email: responseData["data"]["email"],
                            profileImage: responseData["data"]["profile"],
                            professionalId: responseData["data"]["professional_id"],
                            description: responseData["data"]["about"],
                            isLogin: RxInt(responseData["data"]["is_login"] ?? 0),
                            createdAt: responseData["data"]["created_at"],
                            updatedAt: responseData["data"]["updated_at"],
                          ),
                        )),
                (route) => false);
          }
        }
      } else {
        hideLoadingDialog();
        showInSnackBar(responseData["message"], color: Colors.red);
      }
    } else {
      hideLoadingDialog();
      showInSnackBar("Invalid Data ${response.statusCode}", color: Colors.red);
    }
  } on DioException catch (e) {
    hideLoadingDialog();
    showInSnackBar(e.message!, color: Colors.red);
    print("Error Register $e");
  }
}


  registerWithEmail(
    String fullName,
    String email,
    String password,
  ) async {
    showLoadingDialog();
    try {
      var response = await dio.post(APiUrl.registerURL, data: {
        'first_name': fullName,
        'email': email,
        'password': password,
      });
      print('statusCode ${response.statusCode}');
      if (response.statusCode == 200) {
        hideLoadingDialog();
        print('Api Hiiting');
        print(response.data);
        final responseData = response.data;
        // Map<String, dynamic> data = jsonDecode(response.data);

        if (responseData["success"] == true) {
          showInSnackBar(
            responseData["message"],
          );
          Get.to(WelcomeScreen());
        } else {
          showInSnackBar(responseData["message"], color: Colors.red);
        }
      } else {
        hideLoadingDialog();
        showInSnackBar("Invalid Data ${response.statusCode}",
            color: Colors.red);
      }
      print(response.data);
    } on DioException catch (e) {
      showInSnackBar(e.message!, color: Colors.red);
      print("Error Register $e");
    }
  }

//new kamlesh
  // bool servicestatus = false;
  // bool haspermission = false;
  // late LocationPermission permission;
  // late Position position;
  // String lat = '';
  // String lon = '';
  // checkGps() async {
  //   servicestatus = await Geolocator.isLocationServiceEnabled();
  //   if (servicestatus) {
  //     permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         log('Location permissions are denied');
  //       } else if (permission == LocationPermission.deniedForever) {
  //         log("'Location permissions are permanently denied");
  //       } else {
  //         haspermission = true;
  //       }
  //     } else {
  //       haspermission = true;
  //     }

  //     if (haspermission) {
  //       getLocation();
  //     }
  //   } else {
  //     log("GPS Service is not enabled, turn on GPS location");
  //   }
  // }

  // getLocation() async {
  //   position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   log(position.longitude.toString()); //Output: 80.24599079
  //   log(position.latitude.toString()); //Output: 29.6593457

  //   lon = position.longitude.toString();
  //   lat = position.latitude.toString();

  //   // setState() ({
  //   //    //refresh UI
  //   // });

  //   LocationSettings locationSettings = const LocationSettings(
  //     accuracy: LocationAccuracy.high, //accuracy of the location data
  //     distanceFilter: 100, //minimum distance (measured in meters) a
  //     //device must move horizontally before an update event is generated;
  //   );
  // }

//------------------FORGOT PASSWORD WITH EMAIL------------------
  var id = ''.obs;
  updateid(String value) {
    print('inside id change $value');
    id.value = value;
  }

  verifyemailcode(String verifyemail) async {
    showLoadingDialog();

    try {
      var response = await dio.post(APiUrl.sendOTP,
          options: Options(headers: {
            'Authorization': "Bearer  $userToken ",
          }),
          data: {
            'email': verifyemail,
          });
      print('Status Code ${response.statusCode}');

      print('Response Data ${response.data}');
      if (response.statusCode == 200) {
        print(response.data);
        final responseData = response.data;

        if (responseData["success"] == true) {
          print('userId ${responseData["id"]}');
          updateid(responseData["id"].toString());
          print(responseData["code"]);
          showInSnackBar(responseData['message'], color: Colors.green);
          matechCode.value = responseData["code"];
          hideLoadingDialog();
          Get.to(() => VerifyCodeScreen(
                matchcode: responseData["code"],
                email: verifyemail,
              ));
        } else {
          hideLoadingDialog();
          showInSnackBar(responseData['message'], color: Colors.red);
        }
      }
    } catch (e) {
      print('Verfiy Email Errorr  $e');
    }
  }

  forgotPassword(
    String newPassword,
  ) async {
    showLoadingDialog();
    try {
      var response = await dio.post(APiUrl.forgotPassword,
          options: Options(headers: {'Accept': "application/json"}),
          data: {
            'user_id': id.value,
            'password': newPassword,
          });
      print(id.value);
      print('Status Code ${response.statusCode}');

      print('Response Data ${response.data}');
      if (response.statusCode == 200) {
        print(response.data);
        final responseData = response.data;
        if (responseData["success"] == true) {
          Get.to(() => const ChangePasswordScreen());
        } else {
          showInSnackBar(responseData['message'], color: Colors.red);
        }
      }
    } catch (e) {
      print('New Password Errorr  $e');
    }
  }

//------------------FORGOT PASSWORD MEHTOD END------------------
}
