import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hint;
  final String? label;
  final bool? hidetext;
  final Color? fillColor;
  final Color? textColor;
  final IconData? suffixIcon;
  final bool? enabled;
  final bool dealAsDate;
  final Function()? suffixAction;
  int maxLine;
  CustomTextFormField({super.key,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.hint,
    this.label,
    this.hidetext,
    this.fillColor,
    this.textColor,
    this.suffixAction,
    this.enabled,
    this.dealAsDate=false,
    this.maxLine=1,
    this.suffixIcon});


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(label!=null)
          Padding(
              padding: EdgeInsets.only(left: 6.w, bottom: 5.h),
              child: Text(label!, style: AppStyles.textFieldLabel(),)),
          TextFormField(
            controller: controller,
            maxLines: maxLine,
            obscureText: hidetext ?? false,
            cursorColor: textColor ?? AppColors.secondaryText,
            keyboardType: keyboardType ?? TextInputType.text,
            style: AppStyles.textFieldBody(),
            readOnly: dealAsDate,
            onTap: dealAsDate
                ?()=> datePicker(context)
                : null,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              enabled: enabled ?? true,
              fillColor: fillColor ?? AppColors.textFieldBg,
              hintStyle: AppStyles.textFieldBody(),
              contentPadding: maxLine > 1
                  ? EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w)
                  : EdgeInsets.only(left: 14.w, right: 14.w, top: 18.h, bottom: 18.h),
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
              // disabledBorder: InputBorder.none,
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                onTap: suffixAction,
                child: Container(
                  width: 20.w,
                  child: Center(
                    child: Icon(suffixIcon!, size: 20.w,),
                  ),
                ),
              )
                  : null,

            ),
            validator: validator,
          ),
        ],
      )
    );
  }

  static dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
  datePicker(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.black,
              colorScheme: ColorScheme.light(primary: Colors.black,),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child!,
          );
        },
        initialDate: selectedDate,
        firstDate: DateTime(1947, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
