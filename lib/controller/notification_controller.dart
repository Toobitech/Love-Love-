import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../component/api_url.dart';
import '../component/globalvariables.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  List<NotificationModel> notificationList = [];
  var isLoading = false.obs;

  fetchNotificationData() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(APiUrl.notificationsURL),
        headers: {
          'Authorization': "Bearer  $userToken ",
          'Accept': "application/json"
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        NotificationData data12 =
            NotificationData.fromJson(jsonDecode(response.body));
        notificationList = data12.data!;
        log(response.body);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
