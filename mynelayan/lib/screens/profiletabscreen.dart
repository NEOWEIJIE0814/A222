import 'package:flutter/material.dart';
import 'package:mynelayan/screens/loginscreen.dart';
import 'package:mynelayan/screens/registrationscreen.dart';

// for profile screen

class ProfileTabScreen extends StatefulWidget {
  const ProfileTabScreen({super.key});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  late List<Widget> tabchildren;
  String maintitle = "Profile";

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
   // screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoginScreen())) ;
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen())) ;
            },
            child: const Text('Registration'),
          )
        ],
      ),
    );
  }
}
