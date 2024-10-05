import 'dart:convert';
import 'package:dealsdray/Screens/otpScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  bool isPhoneSelected = true;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  
  Future<String?> _getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('deviceId');
  }

 
  Future<void> _storeUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    print("useerId:" + userId);
  }

  Future<void> _sendOtp() async {
    final String phoneNumber = _phoneController.text;
    final String? deviceId = await _getDeviceId();

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your phone number')),
      );
      return;
    }
    if (phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid mobile number')),
      );
      return;
    }

    if (deviceId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Device ID not found')),
      );
      return;
    }

    final Map<String, String> data = {
      'mobileNumber': phoneNumber,
      'deviceId': deviceId,
    };

    try {
      final response = await http.post(
        Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['status'] == 1) {
          final String? userId = responseBody['data']['userId'];

          if (userId != null) {
            
            await _storeUserId(userId);

            
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return OtpScreen(phoneNumber: phoneNumber);
            }));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User ID not found in the response')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    responseBody['data']['message'] ?? 'Failed to send OTP')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset('assets/dealsDray.png', height: 200),
              SizedBox(height: 20),
              ToggleButtons(
                borderRadius: BorderRadius.circular(30),
                isSelected: [isPhoneSelected, !isPhoneSelected],
                onPressed: (int index) {
                  setState(() {
                    isPhoneSelected = index == 0;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('Phone', style: TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('Email', style: TextStyle(fontSize: 16)),
                  ),
                ],
                selectedColor: Colors.white,
                fillColor: Colors.red,
                color: Colors.grey,
                borderColor: Colors.red,
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    'Glad to see you!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Please provide your phone number',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 20),
              isPhoneSelected
                  ? TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    )
                  : TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendOtp, 
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'SEND CODE',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
