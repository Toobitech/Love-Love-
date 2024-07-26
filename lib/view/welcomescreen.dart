import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolovelove/controller/auth_controller.dart';
import 'package:prolovelove/model/user_model.dart';
import 'package:prolovelove/view/edit_profile_form.dart';
import 'package:prolovelove/view/user_mian_screen.dart';
import '../../component/globalvariables.dart';
import '../../helper/assets.dart';
import '../../helper/button.dart';
import '../../helper/colors.dart';
import '../../helper/spacer.dart';
import '../component/social_login_button.dart';
import '../controller/notification_service.dart';
import 'call/calling_service.dart';
import 'login_screen.dart';
import 'registerScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

// class NotificationServices {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   void requestNotificationPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('user granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('user granted provional permission');
//     } else {
//       print('user denied permission');
//     }
//   }

//   void firebaseInit() {
//     FirebaseMessaging.onMessage.listen((message) {
//       if (kDebugMode) {
//         print(message.notification!.title.toString());
//         print(message.notification!.body.toString());
//       }
//       showNotification(message);
//     });
//   }

//   void initLocalNotifications(
//       BuildContext context, RemoteMessage meesage) async {
//     var androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (payload) {},
//     );
//   }

// Future<void> showNotification(RemoteMessage message) async {
//   AndroidNotificationChannel channel = AndroidNotificationChannel(
//       Random.secure().nextInt(1000000).toString(), 'Notification Channel',
//       importance: Importance.max);
//   AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//           channel.id.toString(), channel.name.toString(),
//           channelDescription: 'Description',
//           importance: Importance.high,
//           priority: Priority.high,
//           ticker: 'ticker');
//   NotificationDetails notificationDetails = NotificationDetails(
//     android: androidNotificationDetails,
//   );
//   Future.delayed(Duration.zero, () {
//     _flutterLocalNotificationsPlugin.show(
//         0,
//         message.notification!.title.toString(),
//         message.notification!.title.toString(),
//         notificationDetails);
//   });
// }
//   Future<String> getDeviceToken() async {
//     String? token = await messaging.getToken();
//     return token!;
//   }
// }

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? fcmuserToken;
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTokken();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    // notificationServices.getDeviceToken().then((value) {
    //   if (kDebugMode) {
    //     print('device token');
    //     fcmuserToken = value;
    //     print(value);

    //     print('device User token $fcmuserToken');
    //   }
    // });
    // if (Platform.isAndroid) {
    //   var initializationSettingsAndroid =
    //       const AndroidInitializationSettings('ic_launcher');
    //   var initialzationSettingsAndroid =
    //       const AndroidInitializationSettings('@mipmap/ic_launcher');
    //   var initializationSettings =
    //       InitializationSettings(android: initialzationSettingsAndroid);
    //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // }

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification!.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             // channel.description,
    //             color: Colors.blue,
    //             //      one that already exists in example app.
    //             icon: "@mipmap/ic_launcher",
    //           ),
    //         ));
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         // context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title.toString()),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body.toString())],
    //               ),
    //             ),
    //           );
    //         },
    //         context: context);
    //   }
    // });
  }

  bool isLoading = false;
  getTokken() async {
    if (appStorage.read("tokken") != null) {
      final authController = Get.put(AuthController());

      setState(() {
        isLoading = true;
        userToken = appStorage.read("tokken");
        USERNAME = appStorage.read(userName);
        var userCID = appStorage.read("currentUserId");
        print("SetUserId $userCID");
        onUserLogin(userCID.toString(), USERNAME.toString());
      });
      log(userToken);
      log(USERNAME!);
      Future.delayed(const Duration(seconds: 6), () {
        //new kamlesh

        var professionalId = appStorage.read("professionalId");
        // print("ProfessionalProfesssion $professionID");
        if (professionalId == null) {
          Get.to(
              () => EditProfileForm(userData: UserModel(firstName: USERNAME)));
        } else {
          Get.to(UserMainScreen());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            vertical(70),
            Image.asset(
              AppImages.logo_Icon,
              height: Get.height * 0.1,
            ),
            vertical(20),
            Image.asset(
              AppImages.loveGif,
              height: Get.height * 0.5,
            ),
            // boldtext(AppColors.black, 52, "Welcome"),
            // lighttext(AppColors.black, 12, "You are Awesome!"),
            const Spacer(),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: AppColors.pink,
                  ))
                : buttonMain(0.65, "Login", () {
                    Get.to(() => LoginScreen(
                          fcmToken: fcmuserToken,
                        ));
                  }),
            isLoading
                ? const SizedBox.shrink()
                : socialLoginButton("Already have an account ?", "Sign up", () {
                    Get.to(() => const RegisterScreen());
                  }),
            vertical(25)
          ],
        ),
      ),
    );
  }
}