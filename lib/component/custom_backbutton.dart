import 'package:flutter/material.dart';

import '../helper/colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // behavior: HitTestBehavior.translucent,
      onTap: () {
        print('objectBack');
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: AppColors.black, blurRadius: 6, offset: Offset(0.2, 0.5))
        ], color: AppColors.white, shape: BoxShape.circle),
        child: Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: AppColors.pink,
        ),
      ),
    );
  }
}
