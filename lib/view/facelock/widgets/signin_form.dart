// import 'package:flutter/material.dart';
// import 'package:prolovelove/model/user_model.dart';
// import 'package:prolovelove/view/edit_profile_form.dart';
// import '../../user_mian_screen.dart';
// import '../locator.dart';
// import '../services/camera.service.dart';
// import 'app_button.dart';

// class SignInSheet extends StatelessWidget {
//   final int professionalId;
//   SignInSheet({Key? key, required this.userdata, required this.professionalId})
//       : super(key: key);
//   final UserModel userdata;

//   final _cameraService = locator<CameraService>();

//   Future _signIn(
//     context,
//   ) async {
//     if (professionalId == 0) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (BuildContext context) => EditProfileForm(
//                     userData: userdata,
//                   )));
//     } else {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (BuildContext context) => UserMainScreen()));
//     }

//     // if (user.password == _passwordController.text) {
//     //   Navigator.push(
//     //       context,
//     //       MaterialPageRoute(
//     //           builder: (BuildContext context) => Profile(
//     //                 user.user,
//     //                 imagePath: _cameraService.imagePath!,
//     //               )));
//     // } else {
//     //   showDialog(
//     //     context: context,
//     //     builder: (context) {
//     //       return AlertDialog(
//     //         content: Text('Wrong password!'),
//     //       );
//     //     },
//     //   );
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             child: Text(
//               'Welcome back, ' + userdata.firstName.toString() + '.',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//           Container(
//             child: Column(
//               children: [
//                 SizedBox(height: 10),
//                 // AppTextField(
//                 //   controller: _passwordController,
//                 //   labelText: "Password",
//                 //   isPassword: true,
//                 // ),
//                 SizedBox(height: 10),
//                 Divider(),
//                 SizedBox(height: 10),
//                 AppButton(
//                   text: 'Open',
//                   onPressed: () async {
//                     _signIn(context);
//                   },
//                   icon: Icon(
//                     Icons.arrow_forward,
//                     color: Colors.black,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
