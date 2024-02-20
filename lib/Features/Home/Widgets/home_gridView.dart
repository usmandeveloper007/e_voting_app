import 'package:e_voting_app/Utils/app_colors.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeGridView extends StatelessWidget {
  final String? image;
  final String? title;
  const HomeGridView({super.key, this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300.h,
      width: 300.w,
      decoration: BoxDecoration(
        color: AppColors.appbarBgColor,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 75.h,
            width: 75.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.h),
              color: AppColors.appBgColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image.asset(image!,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(title!, style: TextStyle(color: AppColors.appBgColor),),
          )
        ],
      ),
    );
  }
}
