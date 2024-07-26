import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:prolovelove/component/api_url.dart';
import 'package:prolovelove/model/datetime_model.dart';
import 'package:prolovelove/view/user_mian_screen.dart';
import '../component/alertboxes.dart';
import '../component/globalvariables.dart';
import '../component/snackbar.dart';
import '../model/call_logdata_model.dart';
import '../model/pricing_model.dart';
import '../model/profession_catetory_model.dart';
import '../model/withdraw_model.dart';

final dio = Dio();

class ApiService {
  static deletePricingDetail(int id) async {
    try {
      showLoadingDialog();
      final response = await dio.delete(
        "${APiUrl.detalePricingDeatil}$id",
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );

      print("statusCode =>${response.statusCode}");
      print('Delete Pricing API done 👌✅');
      print('Response Pricing ${response.data.toString()}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        hideLoadingDialog();
        showInSnackBar(responseData["message"], color: Colors.green);
      }
    } catch (e) {
      showInSnackBar('Someting Wrong.....', color: Colors.red);
      hideLoadingDialog();
      print("Delete Pricing APi Error ==>$e");
    }
  }

  static getCallLogs() async {
    try {
      final response = await dio.get(
        APiUrl.getCallLog,
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );
      print("statusCode =>${response.statusCode}");
      print('get Call API done 👌✅');
      print('Response Call Logs ${response.data.toString()}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map) {
          List<DataCallLogsModel> serverResponse =
              (responseData['data'] as List)
                  .map((data) => DataCallLogsModel.fromJson(data))
                  .toList();
          return serverResponse;
        } else {
          return responseData;
        }
        // return responseData['data'];
      }
    } catch (e) {
      showInSnackBar('Someting Wrong.....', color: Colors.red);
      print("Get Call Logs APi Error ==>$e");
    }
  }

  static getPrcingDetail() async {
    try {
      final response = await dio.get(
        APiUrl.getPricingDeatil,
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );
      print("statusCode =>${response.statusCode}");
      print('get Pricing API done 👌✅');
      print('Response Pricing ${response.data.toString()}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map) {
          List<PricingModel> serverResponse = (responseData['data'] as List)
              .map((data) => PricingModel.fromJson(data))
              .toList();
          return serverResponse;
        } else {
          return responseData;
        }
        // return responseData['data'];
      }
    } catch (e) {
      showInSnackBar('Someting Wrong.....', color: Colors.red);
      print("Get Pricing APi Error ==>$e");
    }
  }

  static getBankDetail() async {
    try {
      final response = await dio.get(
        APiUrl.getBankDetail,
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );
      print("statusCode =>${response.statusCode}");
      print('get Ban Detail API done 👌✅');
      print('Response Bank ${response.data.toString()}');
      if (response.statusCode == 200) {
        Map<String, dynamic> dataBase = response.data;
        print(dataBase['data']);
        // final responseData = response.data;
        // if (responseData is Map) {
        //   List<WithdrawModel> serverResponse = (dataBase['data'] as List)
        //       .map((data) => WithdrawModel.fromJson(data))
        //       .toList();
        //   return serverResponse;
        // } else {
        //   return responseData;
        // }
        return dataBase['data'];
      }
    } catch (e) {
      showInSnackBar('Someting Wrong.....', color: Colors.red);
      print("Get Pricing APi Error ==>$e");
    }
  }

  static postAddPricing(String mints, String amount) async {
    try {
      // Get.back();
      // showLoadingDialog();
      print("mints ==> ${mints}");
      log(mints.toString());
      print('$userToken');
      // showLoadingDialog();
      final response = await dio.post(
        APiUrl.addSechdulePricing,
        data: {
          'amount': amount,
          'mins': mints,
        },
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );

      print("statusCode =>${response.statusCode}");
      print('post Add Pricing API done 👌✅');
      print('Response Pricing ${response.data.toString()}');
      if (response.statusCode == 200) {
        // hideLoadingDialog();

        final responseData = response.data;
        if (response.data["success"] == true) {
          showInSnackBar(responseData["message"], color: Colors.green);
        } else {
          showInSnackBar(responseData["message"], color: Colors.red);
        }
        return responseData['data'];
      }
    } catch (e) {
      // hideLoadingDialog();
      showInSnackBar('Someting Wrong.....', color: Colors.red);

      print("Pricing APi Error ==>$e");
    }
  }

  static withdrawAmount(WithdrawModel data) async {
    try {
      showLoadingDialog();
      final response = await dio.post(
        "${APiUrl.withdrawAmount}",
        data: {
          'price': data.amount,
          'bank_name': data.bankName,
          'account_name': data.accName,
          'account_number': data.accNumber,
          'routing_number': data.routingNumber,
        },
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );

      print("statusCode =>${response.statusCode}");
      print('post Withdraw Amount API done 👌✅');
      print('Response Withdraw ${response.data.toString()}');
      if (response.statusCode == 200) {
        hideLoadingDialog();

        final responseData = response.data;
        if (response.data["success"] == true) {
          showInSnackBar(responseData["message"], color: Colors.green);
          Get.to(UserMainScreen());
          // showInSnackBar(responseData["message"], color: Colors.green);
        } else {
          showInSnackBar(responseData["message"], color: Colors.red);
        }
        return responseData['data'];
      }
    } catch (e) {
      // hideLoadingDialog();
      showInSnackBar('Someting Wrong.....', color: Colors.red);

      print("Withdraw Amount APi Error ==>$e");
    }
  }

  static editPricingVal(int id, String mints, String amount) async {
    try {
      log(mints.toString());
      print('$userToken');
      // showLoadingDialog();
      final response = await dio.post(
        "${APiUrl.editPricingDeatil}$id",
        data: {
          'amount': amount,
          'mins': mints,
        },
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );

      print("statusCode =>${response.statusCode}");
      print('post Edited Pricing API done 👌✅');
      print('Response Pricing ${response.data.toString()}');
      if (response.statusCode == 200) {
        // hideLoadingDialog();

        final responseData = response.data;
        if (response.data["success"] == true) {
          showInSnackBar('Pricing Schedule Updated.....', color: Colors.green);
          // showInSnackBar(responseData["message"], color: Colors.green);
        } else {
          showInSnackBar(responseData["message"], color: Colors.red);
        }
        return responseData['data'];
      }
    } catch (e) {
      // hideLoadingDialog();
      showInSnackBar('Someting Wrong.....', color: Colors.red);

      print("Pricing Edit APi Error ==>$e");
    }
  }

  static getProfessionCateory() async {
    try {
      final response = await dio.get(
        APiUrl.professions,
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );

      print("statusCode =>${response.statusCode}");
      print('get Prefession API done 👌✅');
      print('Response Data ${response.data.toString()}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map) {
          List<ProfessionCategory> serverResponse =
              (responseData['data'] as List)
                  .map((data) => ProfessionCategory.fromJson(data))
                  .toList();
          return serverResponse;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      print("Profession Error ==>$e");
    }
  }

  static postCalenderData(List<DateTimeModel> calender) async {
    try {
      // Get.back();
      print("Dates +==> ${calender}");
      // for (DateTimeModel dateTimeModel in calender) {
      //   Map<String, dynamic> jsonMap = dateTimeModel.toJson();
      //   String jsonString = jsonEncode(jsonMap);
      //   print("Dates ==> ${jsonString}");
      // }
      final formdata = FormData();
// jsonEncode(calender)
      formdata.fields.add(MapEntry('data', jsonEncode(calender)));
      log(calender.toString());
      print("Calender ===> ${calender}");
      print('$userToken');
      showLoadingDialog();
      final response = await dio.post(
        APiUrl.postCalenderData,
        data: formdata,
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );

      print("statusCode =>${response.statusCode}");
      print('post Calender API done 👌✅');
      print('Response Calender ${response.data.toString()}');
      if (response.statusCode == 200) {
        hideLoadingDialog();

        final responseData = response.data;

        showInSnackBar(responseData["message"], color: Colors.green);
        return responseData['data'];
      }
    } catch (e) {
      hideLoadingDialog();
      showInSnackBar('Someting Wrong.....', color: Colors.red);

      print("Calender APi Error ==>$e");
    }
  }

  static deleteCalenderData(int id) async {
    try {
      final response = await dio.delete(
        "${APiUrl.deleteCalenderData}$id",
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );

      print("statusCode =>${response.statusCode}");
      print('Delete Calender API done 👌✅');
      print('Response Calender ${response.data.toString()}');
      if (response.statusCode == 200) {
        final responseData = response.data;

        showInSnackBar(responseData["message"], color: Colors.green);
      }
    } catch (e) {
      showInSnackBar('Someting Wrong.....', color: Colors.red);
      print("Delete Calender APi Error ==>$e");
    }
  }

  static getCalenderData(String date) async {
    try {
      final response = await dio.get(
        "${APiUrl.getCalenderData}$date",
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );

      print("statusCode =>${response.statusCode}");
      print('get Calender API done 👌✅');
      print('Response Calender ${response.data.toString()}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map) {
          List<DateTimeModel> serverResponse = (responseData['data'] as List)
              .map((data) => DateTimeModel.fromJson(data))
              .toList();
          return serverResponse;
        } else {
          return responseData;
        }
      }
    } catch (e) {
      showInSnackBar('Someting Wrong.....', color: Colors.red);
      print("Get Calender APi Error ==>$e");
    }
  }

  static changeUserStatus(int val) async {
    try {
      Get.back();
      showLoadingDialog();
      final response = await dio.get(
        APiUrl.userStatus,
        queryParameters: {'is_online': val},
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );

      print("statusCode =>${response.statusCode}");
      print('get User Status API done 👌✅');
      print('Response Status ${response.data.toString()}');
      if (response.statusCode == 200) {
        hideLoadingDialog();
        final responseData = response.data;
        showInSnackBar(responseData["message"], color: Colors.green);
        return responseData['data'];
      }
    } catch (e) {
      print("User Status Error ==>$e");
    }
  }

  static getUserData() async {
    try {
      final response = await dio.get(
        APiUrl.getUserData,
        options: Options(headers: {
          'Authorization': "Bearer  $userToken ",
        }),
      );

      print("statusCode =>${response.statusCode}");
      print('get User Data API done 👌✅');
      print('Response Data ${response.data.toString()}');
      if (response.statusCode == 200) {
        final responseData = response.data;
        return responseData['data'];
        // if (responseData is Map) {
        //   List<UserModel> serverResponse = (responseData['data'].value as List)
        //       .map((data) => UserModel.fromJson(data))
        //       .toList();
        //   return serverResponse;
        // } else {
        //   return responseData;
        // }
      }
    } catch (e) {
      print("User Data Error ==>$e");
    }
  }
}
