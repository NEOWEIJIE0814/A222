import 'package:barterit/model/user.dart';
import 'package:barterit/screen/owneritemscreen.dart';
import 'package:barterit/screen/loginscreen.dart';
import 'package:barterit/screen/profiletab.dart';
import 'package:flutter/material.dart';

import 'barterscreen.dart';
import 'contactscreen.dart';

class ControlScreen extends StatefulWidget {
  final User user;
  const ControlScreen({super.key, required this.user});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Barter";

  @override
  void initState() {
    super.initState();
    //\print(widget.user.name);
    print("Barterscreen");
    tabchildren = [
      BarterScreen(
        user: widget.user,
      ),
      OwnerItemScreen(user: widget.user),
      ContactScreen(user: widget.user),
      ProfileTab(user: widget.user),
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
                  Icons.swap_horiz,
                ),
                label: "Barter"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.card_giftcard_outlined,
                ),
                label: "Owner"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.contacts,
                ),
                label: "Contact"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile"),
          ]),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 0) {
        maintitle = "Barter";
      }
      if (_currentIndex == 1) {
        maintitle = "Owner";
      }
      if (_currentIndex == 2) {
        maintitle = "Contact";
      }
      if (_currentIndex == 3) {
        maintitle = "Profile";
      }
    });
  }
}
