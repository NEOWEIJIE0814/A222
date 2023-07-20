import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:barterit/model/user.dart';
import 'package:barterit/screen/controlscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'myconfig.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAndLogin();
    //login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/barter.png'),
                      fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 650, 0, 0),
            child: Column(
              children: [
                CircularProgressIndicator(),
              ],
            ),
          )
        ],
      ),
    );
  }

  checkAndLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    bool ischeck = (prefs.getBool('checkbox')) ?? false;
    late User user;
    if (ischeck) {
      try {
        http.post(Uri.parse("${MyConfig().SERVER}/barterit/php/login.php"),
            body: {"email": email, "password": password}).then((response) {
          if (response.statusCode == 200) {
            var jsondata = jsonDecode(response.body);
            if (jsondata['status'] == "success") {
            user = User.fromJson(jsondata['data']);
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => ControlScreen(user: user))));
            } 
          } else {
            user = User(
              id: "na",
              name: "na",
              email: "na",
              phone: "na",
              datereg: "na",
              password: "na",
              otp: "na",
              token: "0",
            );
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => ControlScreen(user: user))));
          }
        }).timeout(const Duration(seconds: 5), onTimeout: () {
          // Time has run out, do what you wanted to do.
        });
      } on TimeoutException catch (_) {
        print("Time out");
      }
    } else {
      user = User(
        id: "na",
        name: "na",
        phone: "na",
        email: "na",
        datereg: "na",
        password: "na",
        otp: "na",
        token: "0",
      );
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => ControlScreen(user: user))));
    }
  }
  
  void login() {
    late User user;
     user = User(
        id: "na",
        name: "na",
        phone: "na",
        email: "na",
        datereg: "na",
        password: "na",
        otp: "na",
        token: "0",
      );
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => ControlScreen(user: user))));
  }

  
}
