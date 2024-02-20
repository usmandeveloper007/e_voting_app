import 'package:e_voting_app/Features/Authentication/View/register_view.dart';
import 'package:e_voting_app/Utils/app_colors.dart';
import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:e_voting_app/Utils/app_styles.dart';
import 'package:e_voting_app/Widgets/custom_button.dart';
import 'package:e_voting_app/Widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Home/View/home_screen.dart';
import '../Controller/authentication_controller.dart';
import 'forget_password.dart';

class Login extends StatelessWidget {
   Login({super.key});

   final loginFormKey = GlobalKey<FormState>();
  final AuthenticationController authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/evoteblack300.png"),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: CustomTextFormField(
                    controller: authController.email,
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address';
                      }
                      return null;
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: CustomTextFormField(
                    controller: authController.password,
                    hint: 'Enter your password',
                    hidetext: true,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: Icons.password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    }),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: forgetPassword(),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Obx(
                ()=> CustomButton(
                  label: 'Log In',
                  bgColor: Colors.black,
                  loader: authController.loader.value,
                  fun: (){
                    if(loginFormKey.currentState!.validate()){
                      authController.loginAccount();
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h, top: 10.h),
          child: TextButton(
              onPressed: (){
                CustomTextFormField.dismissKeyboard();
                authController.getCityPartyName();
                Get.to(()=> register());
              },
              child: Text(
                "Register Now",
                style: AppStyles.buttonLabel().copyWith(
                  color: Colors.black,
                ),
              )
          )),
    );
  }

  Widget forgetPassword(){
    return TextButton(
        onPressed: (){
          CustomTextFormField.dismissKeyboard();
          Get.to(()=> ForgetPassword());
        },
        child: Text(
          AppStrings.forgottenPassword,
          style: AppStyles.buttonLabel().copyWith(
            color: Colors.black,
          ),
        )
    );
  }
}
