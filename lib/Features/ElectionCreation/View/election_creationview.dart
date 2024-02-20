import 'package:e_voting_app/Features/Authentication/View/login_view.dart';
import 'package:e_voting_app/Widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Widgets/custom_button.dart';

class ElectionCreation extends StatefulWidget {
  const ElectionCreation({super.key});

  @override
  State<ElectionCreation> createState() => _ElectionCreation();
}

class _ElectionCreation extends State<ElectionCreation> {
  final _constituency = TextEditingController();
  final _electiontype = TextEditingController();
  final _electiondate = TextEditingController();
  final _votingstarttime = TextEditingController();
  final _votingendtime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    controller: _constituency,
                    hidetext: false,
                    keyboardType: TextInputType.name,
                    hint: 'Enter the Constituency',
                    suffixIcon: Icons.location_city,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the constituency';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    controller: _electiontype,
                    hidetext: false,
                    keyboardType: TextInputType.name,
                    hint: 'Enter the election type',
                    suffixIcon: Icons.merge_type,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter election type';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    controller: _electiondate,
                    hidetext: false,
                    keyboardType: TextInputType.datetime,
                    hint: 'Enter the election date',
                    suffixIcon: Icons.date_range,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the date';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    controller: _votingstarttime,
                    hidetext: false,
                    keyboardType: TextInputType.datetime,
                    hint: 'Enter the voting start time',
                    suffixIcon: Icons.access_time_filled_sharp,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the time';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: CustomTextFormField(
                    controller: _votingendtime,
                    hidetext: false,
                    keyboardType: TextInputType.datetime,
                    hint: 'Enter the voting end time',
                    suffixIcon: Icons.access_time_filled_sharp,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 50.h,
                ),
                CustomButton(
                  label: 'Create Election',
                  bgColor: Colors.black,
                  fun: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Login())),
                ),
              ],
            )),
      ),
    );
  }
}
