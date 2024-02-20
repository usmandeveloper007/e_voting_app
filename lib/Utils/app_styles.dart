import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_assets.dart';
import 'app_colors.dart';

class AppStyles {
  static TextStyle appbarTitleStyle(){
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      fontFamily: AppAssets.interFont,
      color: Colors.white,
    );
  }

  static TextStyle buttonLabel(){
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      fontFamily: AppAssets.interFont,
      decoration: TextDecoration.none,
      color: Colors.white
    );
  }

  static TextStyle customStyle({double? size, Color? color, FontWeight? weight})=>TextStyle(
    fontWeight:weight ?? FontWeight.w400, fontSize:size ?? 14.sp,
    color:color ?? Colors.black,
  );

  static TextStyle buttonLabel2(){
    return TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        fontFamily: AppAssets.interFont,
        decoration: TextDecoration.none,
        color: Colors.black
    );
  }

  static TextStyle textFieldBody(){
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      fontFamily: AppAssets.interFont,
      color: AppColors.secondaryText,
    );
  }

  static TextStyle textFieldLabel(){
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppAssets.interFont,
      color: AppColors.secondaryText,
    );
  }


}