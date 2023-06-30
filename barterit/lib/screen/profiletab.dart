import 'package:barterit/model/user.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';
import 'registerscreen.dart';

class ProfileTab extends StatefulWidget {
  final User user;
  const ProfileTab({super.key, required this.user});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late List<Widget> tabchildren;
    String maintitle = "Profile";
    late double screenHeight, screenWidth, cardwitdh;
    @override
    void initState() {
      super.initState();
      print("Profile");
    }

    @override
    void dispose() {
      super.dispose();
      print("dispose");
    }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body:  Center(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: screenHeight * 0.25,
            width: screenWidth,
            child: Card(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.all(4),
                  width: screenWidth * 0.4,
                  child: Image.asset(
                    "assets/images/profile.png",
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Text(
                          widget.user.name.toString(),
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(widget.user.email.toString()),
                        Text(widget.user.datereg.toString()),
                      ],
                    )),
              ]),
            ),
          ),
          Container(
            width: screenWidth,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.background,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
              child: Text("PROFILE SETTINGS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) =>  LoginScreen(user: widget.user)));
                },
                child: const Text("LOGIN"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) =>  RegisterScreen(user: widget.user)));
                },
                child: const Text("REGISTRATION"),
              ),
            ],
          ))
        ]),
      ),
    );
  }
}
