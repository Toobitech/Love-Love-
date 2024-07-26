import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'common.dart';

ZegoUIKitPrebuiltCallController? callController;

void onUserLogin(String currentUserID, String currentUser) {
  print('Calling Service Working_____________++++++++++');
  print("NameUserLogin $currentUserID +++ $currentUser");

  callController ??= ZegoUIKitPrebuiltCallController();

  /// 4/5. initialized ZegoUIKitPrebuiltCallInvitationService when account is logged in or re-logged in
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: 320521940 /*input your AppID*/,
    appSign:
        'c0e1969df775800909acbe0e15d8379c96a23d5e87d852f9bfa504915db7f4b1' /*input your AppSign*/,
    userID: currentUserID,
    userName: currentUser,
    notifyWhenAppRunningInBackgroundOrQuit: true,
    plugins: [ZegoUIKitSignalingPlugin()],
    controller: callController,
    events: ZegoUIKitPrebuiltCallInvitationEvents(
      onIncomingCallCanceled: (String callID, ZegoCallUser caller) {
        print('calling........._12');

        ///  Add your custom logic here.
      },
      onIncomingCallDeclineButtonPressed: () {
        print('calling........._1');

        ///  Add your custom logic here.
      },
      onIncomingCallAcceptButtonPressed: () {
        print('calling........._2');

        ///  Add your custom logic here.
      },
      onOutgoingCallCancelButtonPressed: () {
        print('calling........._3');
        Get.back();

        ///  Add your custom logic here.
      },
      onOutgoingCallAccepted: (String callID, ZegoCallUser callee) {
        print('calling........._4');

        ///  Add your custom logic here.
      },
      onOutgoingCallRejectedCauseBusy: (String callID, ZegoCallUser callee) {
        print('calling........._5');

        ///  Add your custom logic here.
      },
      onOutgoingCallDeclined: (String callID, ZegoCallUser callee) {
        print('calling........._6');

        ///  Add your custom logic here.
      },
    ),
    requireConfig: (ZegoCallInvitationData data) {
      final config = data.type == ZegoCallType.videoCall
          ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

      config.durationConfig.isVisible = true;
      config.avatarBuilder = customAvatarBuilder;
      config.onHangUp = () {
        Get.back();
        print('calling.......flutter pub cache repair.....21212');
      };

      /// support minimizing, show minimizing button
      config.topMenuBarConfig.isVisible = true;
      config.topMenuBarConfig.buttons
          .insert(0, ZegoMenuBarButtonName.minimizingButton);

      return config;
    },
  );
}

/// on user logout
void onUserLogout() {
  callController = null;

  /// 5/5. de-initialization ZegoUIKitPrebuiltCallInvitationService when account is logged out
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}
