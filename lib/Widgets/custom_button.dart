import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_strings.dart';
import '../Utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color? bgColor;
  final Color? labelColor;
  final double? radius;
  final Function()? fun;
  final bool loader;


  CustomButton({super.key, required this.label, this.bgColor, this.radius, this.labelColor, this.fun,this.loader=false,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Align(
        alignment: Alignment.center,
        child: Material(
          elevation: 5,
          shadowColor: bgColor ?? AppColors.mainColor.withOpacity(0.6),
          color: bgColor ?? AppColors.mainColor,
          borderRadius: BorderRadius.circular(radius ?? 15.r),
          child: Container(
            height: 52.h,
            width: 328.w,
            decoration: BoxDecoration(
              color: bgColor ?? AppColors.mainColor,
              borderRadius: BorderRadius.circular(radius ?? 15.r),

            ),//
            child: Center(
              child: Text(
                loader
                    ? AppStrings.pleaseWait
                    : label,
                style: bgColor == AppColors.appbarBgColor
                     ? AppStyles.buttonLabel()
                     : AppStyles.buttonLabel2(),
              ),),
          ),
        ),
      ),
    );
  }
}
