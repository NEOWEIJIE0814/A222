import 'package:barterit/screen/loginscreen.dart';
import 'package:barterit/screen/registerscreen.dart';
import 'package:flutter/material.dart';

import 'mainscreen.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Main";

  @override
  void initState() {
    super.initState();
   // print(widget.user.name);
    print("Mainscreen");
    tabchildren = [
      MainScreen(),
      LoginScreen(),
      RegisterScreen(),
    ];
  }
  
  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Main"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.door_front_door,
                ),
                label: "Login"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Register"),
            
          ]),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 0) {
        maintitle = "Main";
      }
      if (_currentIndex == 1) {
        maintitle = "Login";
      }
      if (_currentIndex == 2) {
        maintitle = "Register";
      }
      
    });
  }
}