import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text("Something went wrong :( ",style: TextStyle(color: Colors.red.withOpacity(0.5)),),
    );
  }
}
