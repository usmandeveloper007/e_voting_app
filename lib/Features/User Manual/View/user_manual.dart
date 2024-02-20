import 'package:e_voting_app/Utils/app_strings.dart';
import 'package:e_voting_app/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Home/View/drawer_screen.dart';

class userManual extends StatefulWidget {
   final String ?videoId;
    userManual({Key? key, required this.videoId});
  @override
  State<userManual> createState() => _userManualState();
}

class _userManualState extends State<userManual> {
  final videoURL = "https://www.youtube.com/watch?v=YMx8Bbev6T4";
  YoutubePlayerController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )
      ..addListener(listener);
  }
  void listener() {
    if (_controller?.value.errorCode != null) {
      print(_controller?.value.errorCode);
    }
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(
        title: AppStrings.userManual,
    ),
        drawer: const DrawerScreen(),
        body: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            YoutubePlayer(
              controller: _controller!,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
              onEnded: (data) {
                _controller!
                  ..load(widget.videoId ?? "")
                  ..play();
              },
            )
          ],
        ),
    );
  }
}
