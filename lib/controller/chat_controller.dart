import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prolovelove/component/api_url.dart';

import '../component/globalvariables.dart';

class CharController extends GetxController {
  List userIdFirebase = [];

  updateUserId(List data) {
    userIdFirebase = data;
    update();
  }

  sendSpamMsg(String msg) async {
    print(userIdFirebase);
    try {
      final response =
          await http.post(Uri.parse(APiUrl.disappearURL), headers: {
        'Authorization': "Bearer  $userToken ",
        'Accept': "application/json"
      }, body: {
        "sender_id": appStorage.read(USERID).toString(),
        "receiver_id": userIdFirebase[0] == appStorage.read(USERID)
            ? userIdFirebase[1].toString()
            : userIdFirebase[0].toString(),
        "message": msg
      });

      print(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(data);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
