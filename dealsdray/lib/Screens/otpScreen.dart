import 'dart:async';
import 'dart:convert';
import 'package:dealsdray/Screens/homeScreen.dart';
import 'package:dealsdray/Screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? _timer;
  int _start = 120;
  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  String otp = '';

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timer?.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    for (var controller in otpControllers) {
      controller.addListener(_handleOtpChange);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.removeListener(_handleOtpChange);
    }
    super.dispose();
  }

  // Handle OTP input change
  void _handleOtpChange() {
    otp = otpControllers.map((controller) => controller.text).join();
    if (otp.length == 4) {
      _verifyOtp(); // Automatically trigger OTP verification when 4 digits are entered
    }
  }

  // Function to get deviceId and userId from SharedPreferences
  Future<Map<String, String?>> _getDeviceAndUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString('deviceId');
    final userId = prefs.getString('userId');
    return {
      'deviceId': deviceId,
      'userId': userId,
    };
  }

  // Function to verify OTP
  Future<void> _verifyOtp() async {
    final ids = await _getDeviceAndUserId();
    final String? deviceId = ids['deviceId'];
    final String? userId = ids['userId'];

    if (deviceId == null || userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Device ID or User ID not found')),
      );
      return;
    }

    // Prepare the data for OTP verification
    final Map<String, String> data = {
      'otp': otp,
      'deviceId': deviceId,
      'userId': userId,
    };

    try {
      final response = await http.post(
        Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp/verification'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 1) {
          // OTP verified successfully, navigate to HomeScreen
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return HomeScreen();
          }));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(responseBody['message'] ?? 'OTP verification failed')),
          );
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return RegisterScreen();
          }));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP verification failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/otp1.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Text(
                            'OTP Verification',
                            style: TextStyle(
                                fontSize: 29, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'We have sent a unique OTP number',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'to your mobile +91-9765322817',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 50,
                          height: 70,
                          child: TextField(
                            controller: otpControllers[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              counterText: "",
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(timerText, style: TextStyle(fontSize: 18)),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: _start == 0
                              ? () {
                                  setState(() {
                                    _start = 120;
                                    startTimer();
                                  });
                                }
                              : null,
                          child: Text(
                            'SEND AGAIN',
                            style: TextStyle(
                              fontSize: 18,
                              color: _start == 0 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
