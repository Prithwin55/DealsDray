import 'package:dealsdray/Screens/homeScreen.dart';
import 'package:dealsdray/Screens/otpScreen.dart';
import 'package:dealsdray/Screens/phoneScreen.dart';
import 'package:dealsdray/Screens/registerScreen.dart';
import 'package:dealsdray/Screens/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
