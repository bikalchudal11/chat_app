// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/pages/check_sender/check_sender.dart';
import 'package:chat_app/pages/view_page/chat_msg.dart';
import 'package:chat_app/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> checkIfUserIdExists() async {
    var prefs = await SharedPreferences.getInstance();
    int? savedId = prefs.getInt("sender_id");
    if (savedId == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CheckSender()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ChatMsg(
                senderId: savedId,
              )));
    }
  }

  @override
  void initState() {
    checkIfUserIdExists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Group Messaging App",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: sColor,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: sColor,
            )
          ],
        ),
      ),
    );
  }
}
