import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_textfield.dart';
import '../Controller/authentication_controller.dart';

class ForgetPassword extends StatelessWidget {
   ForgetPassword({Key? key}) : super(key: key);
  final passFormKey = GlobalKey<FormState>();
  final AuthenticationController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: passFormKey,
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
                height: 60.h,
              ),
              Obx(
                    ()=> CustomButton(
                    label: 'Sent Email',
                    bgColor: Colors.black,
                    loader: authController.loader.value,
                    fun: (){
                      CustomTextFormField.dismissKeyboard();
                      if(passFormKey.currentState!.validate()){
                        authController.resetAccount();
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
