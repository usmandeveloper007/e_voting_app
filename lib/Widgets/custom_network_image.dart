import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_voting_app/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;
  final double? radius;

  const CustomNetworkImage(
      {super.key, this.url, this.height, this.width, this.radius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular((radius ?? 4).r),
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          height: height ?? 80.h,
          width: width ?? 83.w,
          imageUrl: url.toString(),
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Center(
                child: CircleAvatar(
                  backgroundColor: AppColors.appBgColor,
                  radius: 40.sp,
                  child: Icon(
                    Icons.person,
                    color: AppColors.appbarBgColor,
                    size: 42,
                  ),
                ),
              )),
    );
  }
}
