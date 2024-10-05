import 'dart:async';
import 'dart:convert';
import 'package:dealsdray/Screens/phoneScreen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String deviceInfo = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getDeviceDetails();
    _startLoading();
  }

  Future<void> _getDeviceDetails() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceData;

    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        var androidInfo = await deviceInfoPlugin.androidInfo;
        await _saveDeviceId(androidInfo.id);
        deviceData = {
          "deviceType": "android",
          "deviceId": androidInfo.id,
          "deviceName": androidInfo.model,
          "deviceOSVersion": androidInfo.version.release,
          "deviceIPAddress": "11.433.445.66",
          "lat": 9.9312,
          "long": 76.2673,
          "buyer_gcmid": "",
          "buyer_pemid": "",
          "app": {
            "version": "1.20.5",
            "installTimeStamp": "2022-02-10T12:33:30.696Z",
            "uninstallTimeStamp": "2022-02-10T12:33:30.696Z",
            "downloadTimeStamp": "2022-02-10T12:33:30.696Z"
          }
        };
        print(deviceData);
      } else {
        deviceData = {"deviceType": "unknown"};
        print(deviceData);
      }

      setState(() {
        deviceInfo = jsonEncode(deviceData);
      });

      await _sendDeviceInfo(deviceData);
    } on PlatformException {
      deviceData = {"Error": "Failed to get platform information"};
    }
  }

  Future<void> _saveDeviceId(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceId', deviceId);
    print('Device ID saved to Shared Preferences: $deviceId');
  }

  Future<void> _sendDeviceInfo(Map<String, dynamic> deviceData) async {
    const String url = 'http://devapiv4.dealsdray.com/api/v2/user/device/add';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(deviceData), 
      );

      if (response.statusCode == 200) {
        print("Device info sent successfully");
        print(response.body); 
      } else {
        print("Failed to send device info: ${response.statusCode}");
        print(response.body);
      }
    } catch (error) {
      print("Error sending device info: $error");
    }
  }

  void _startLoading() {
    Timer(Duration(seconds: 3), () {
      // setState(() {
      //   isLoading = false;
      // });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return PhoneScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/seemless.png',
            fit: BoxFit.cover,
          ),
          Center(
            // child: CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            // ),
            child: SpinKitCircle(
              color: Colors.red,
              size: 50,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  width: 350,
                  height: 250,
                  child: Image.asset(
                    'assets/splashLogo.png',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
