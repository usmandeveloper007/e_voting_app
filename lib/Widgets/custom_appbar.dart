import 'package:e_voting_app/Features/Home/View/drawer_screen.dart';
import 'package:e_voting_app/Utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Utils/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56.h);
  final String? title;

  const CustomAppbar({super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appbarBgColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leadingWidth: 60.w,
      leading: Builder(builder: (BuildContext context) {
        return IconButton(onPressed: () {
          Scaffold.of(context).openDrawer();
        }, icon: const Icon(Icons.menu, color: AppColors.appBgColor,),
        padding: EdgeInsets.only(top: 12.h),);
      }),
      title: title != null ? Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Text(title!)) : null,
      titleTextStyle: AppStyles.appbarTitleStyle(),
    );
  }
}


