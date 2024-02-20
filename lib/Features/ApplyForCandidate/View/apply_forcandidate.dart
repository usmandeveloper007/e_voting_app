import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:e_voting_app/Widgets/custom_appbar.dart';
import 'package:e_voting_app/Widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Widgets/custom_button.dart';
import '../../Home/View/drawer_screen.dart';
import '../../Home/View/home_screen.dart';
class ApplyForCandidate extends StatefulWidget {
  const ApplyForCandidate({super.key});

  @override
  State<ApplyForCandidate> createState() => _ApplyForCandidateState();
}

class _ApplyForCandidateState extends State<ApplyForCandidate> {
  final _userId = TextEditingController();
  final _constituency = TextEditingController();
  final _electionType = TextEditingController();
  final _designation = TextEditingController();
  final _party = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppbar(
        title: AppStrings.userManual,
      ),
      drawer:  const DrawerScreen(),
      body: SingleChildScrollView(
        child: Form(
            child: Padding(
              padding:  EdgeInsets.only(left: 20.w, right: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.h,
                  ),
                  CustomTextFormField(controller: _userId, hidetext: false,keyboardType: TextInputType.text,hint: 'User ID'),
                  SizedBox(height: 20.h,),
                  CustomTextFormField(controller: _constituency, hidetext: false,keyboardType: TextInputType.text,hint: 'Constituency',),
                  SizedBox(height: 20.h,),
                  CustomTextFormField(controller: _electionType, hidetext: false,keyboardType: TextInputType.text,hint: 'Election Type'),
                  SizedBox(height: 20.h,),
                  CustomTextFormField(controller: _designation, hidetext: false,keyboardType: TextInputType.text,hint: 'Designation'),
                  SizedBox(height: 20.h,),
                  CustomTextFormField(controller: _party, hidetext: false,keyboardType: TextInputType.text,hint: 'Party'),
                  SizedBox(height: 50.h,),
                  CustomButton(
                    label: 'Submit for Review',
                    bgColor: Colors.black,
                    fun: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const HomeScreen())),
                  ),
                ],
        ),
            )),
      ),
    );
  }
}
