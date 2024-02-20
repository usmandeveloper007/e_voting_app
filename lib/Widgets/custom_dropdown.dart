import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_styles.dart';


class CustomDropdown extends StatelessWidget {
 final selectedValue;
 final String? hint;
 final List<String>itemList;
 final String? Function(String?)? validator;

 CustomDropdown({super.key, this.selectedValue, required this.itemList, this.hint,  this.validator,});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<String>(
          isExpanded: true,
          isDense: true,
          hint: Text(
            hint.toString(),
            style: AppStyles.textFieldBody(),
          ),
          iconStyleData: IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down_sharp, color: AppColors.secondaryText,),
              iconSize: 24.sp
          ),
          items: itemList
              .map((String item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item,
                style: AppStyles.customStyle(size: 16.sp).copyWith(
                  color:  AppColors.secondaryText,
                )),
          ))
              .toList(),
          value: selectedValue.value,
          onChanged: (String? value) {
            selectedValue.value = value;
          },
          dropdownStyleData: DropdownStyleData(
              elevation: 1,
              decoration: BoxDecoration(
                color: AppColors.textFieldBg,
                borderRadius: BorderRadius.circular(10.r),
              )
          ),
          decoration: InputDecoration(
            fillColor: AppColors.textFieldBg,
            filled: true,
            contentPadding: EdgeInsets.only(left: 0.w, right: 14.w, top: 16.h, bottom: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color:  Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color:  AppColors.mainColor,
              ),
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}

