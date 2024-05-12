import 'package:chat_app/pages/chat_home.dart';
import 'package:chat_app/pages/check_sender/check_sender.dart';
import 'package:chat_app/pages/splash/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Poppins"),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
