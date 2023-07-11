import 'dart:convert';
import 'package:barterit/screen/topuptokenscreen.dart';
import 'package:http/http.dart' as http;

import 'package:barterit/model/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../myconfig.dart';
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
  final df = DateFormat('dd/MM/yyyy');
  late double screenHeight, screenWidth, cardwitdh;
  @override
  void initState() {
    super.initState();
    print("Profile");
    setstate() {}
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
      body: Center(
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
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 8),
                          child: Divider(
                            color: Colors.blueGrey,
                            height: 2,
                            thickness: 2.0,
                          ),
                        ),
                        Table(
                          columnWidths: const {
                            0: FractionColumnWidth(0.3),
                            1: FractionColumnWidth(0.7)
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(children: [
                              const Icon(Icons.email),
                              Text(widget.user.email.toString()),
                            ]),
                            TableRow(children: [
                              const Icon(Icons.phone),
                              Text(widget.user.phone.toString()),
                            ]),
                            widget.user.datereg.toString() == ""
                                ? TableRow(children: [
                                    const Icon(Icons.date_range),
                                    Text(df.format(DateTime.parse(
                                        widget.user.datereg.toString())))
                                  ])
                                : TableRow(children: [
                                    const Icon(Icons.date_range),
                                    Text(df.format(DateTime.parse(
                                        widget.user.datereg.toString())))
                                  ]),
                            TableRow(children: [
                              const Icon(Icons.monetization_on),
                              Text(widget.user.token.toString()),
                            ]),
                          ],
                        ),
                      ],
                    )),
              ]),
            ),
          ),
          Container(
            width: screenWidth,
            alignment: Alignment.center,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
              child: Text("PROFILE SETTINGS",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Container(
            child: Expanded(
                child: ListView(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              shrinkWrap: true,
              children: [
                const Divider(
                  height: 2,
                ),
                Card(
                  elevation: 10,
                  child: MaterialButton(
                    onPressed: () => {_updateProfileDialog(1)},
                    child: const Text(
                      "CHANGE NAME",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: MaterialButton(
                    onPressed: () => {_updateProfileDialog(2)},
                    child: const Text("CHANGE PHONE",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: MaterialButton(
                    onPressed: () => {_updateProfileDialog(3)},
                    child: const Text("CHANGE PASSWORD",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>
                                  LoginScreen(user: widget.user)));
                    },
                    child: const Text("LOGIN",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>
                                  RegisterScreen(user: widget.user)));
                    },
                    child: const Text("REGISTRATION",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => TopUpTokenScreen(
                                      user: widget.user,
                                      
                                      ))); //need to change router to payment
                          _loadNewCredit(); // do the function
                        },
                        child: const Text("TOP UP BARTER TOKEN",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ]),
      ),
    );
  }

  _updateProfileDialog(int i) {
    switch (i) {
      case 1:
        _updateNameDialog();
        break;
      case 2:
        _updatePhoneDialog();
        break;
      case 3:
        _updatePasswordDialog();
        break;
    }
  }

  void _updateNameDialog() {
    TextEditingController _nameEditingController = TextEditingController();
    _nameEditingController.text = widget.user.name.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Name",
            style: TextStyle(),
          ),
          content: TextField(
              controller: _nameEditingController,
              keyboardType: TextInputType.phone),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                child: const Text(
                  "Confirm",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  http.post(
                      Uri.parse(
                          "${MyConfig().SERVER}/barterit/php/update_profile.php"), // Need to change
                      body: {
                        "name": _nameEditingController.text,
                        "userid": widget.user.id
                      }).then((response) {
                    var data = jsonDecode(response.body);
                    //  print(data);
                    if (response.statusCode == 200 &&
                        data['status'] == 'success') {
                      Fluttertoast.showToast(
                          msg: "Success",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.green,
                          fontSize: 14.0);
                      setState(() {
                        widget.user.name = _nameEditingController.text;
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Failed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.red,
                          fontSize: 14.0);
                    }
                  });
                },
              ),
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
          ],
        );
      },
    );
  }

  void _updatePhoneDialog() {
    TextEditingController _phoneEditingController = TextEditingController();
    _phoneEditingController.text = widget.user.phone.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Phone Number",
            style: TextStyle(),
          ),
          content: TextField(
              controller: _phoneEditingController,
              keyboardType: TextInputType.phone),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text(
                    "Confirm",
                    style: TextStyle(),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    http.post(
                        Uri.parse(
                            "${MyConfig().SERVER}/barterit/php/update_profile.php"), // Need to change
                        body: {
                          "phone": _phoneEditingController.text,
                          "userid": widget.user.id
                        }).then((response) {
                      var data = jsonDecode(response.body);
                      // print(data);
                      if (response.statusCode == 200 &&
                          data['status'] == 'success') {
                        Fluttertoast.showToast(
                            msg: "Success",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.green,
                            fontSize: 14.0);
                        setState(() {
                          widget.user.phone = _phoneEditingController.text;
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Failed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.red,
                            fontSize: 14.0);
                      }
                    });
                  },
                ),
                TextButton(
                  child: const Text(
                    "Cancel",
                    style: TextStyle(),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _updatePasswordDialog() {
    TextEditingController _pass1editingController = TextEditingController();
    TextEditingController _pass2editingController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Update Password",
            style: TextStyle(),
          ),
          content: SizedBox(
            height: screenHeight / 5,
            child: Column(
              children: [
                TextField(
                    controller: _pass1editingController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'New password',
                        labelStyle: TextStyle(),
                        icon: Icon(
                          Icons.password,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ))),
                TextField(
                    controller: _pass2editingController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Renter password',
                        labelStyle: TextStyle(),
                        icon: Icon(
                          Icons.password,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Confirm",
                style: TextStyle(),
              ),
              onPressed: () {
                if (_pass1editingController.text !=
                    _pass2editingController.text) {
                  Fluttertoast.showToast(
                      msg: "Passwords are not the same",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.red,
                      fontSize: 14.0);
                  return;
                }
                if (_pass1editingController.text.isEmpty ||
                    _pass2editingController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Fill in passwords",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.red,
                      fontSize: 14.0);
                  return;
                }
                Navigator.of(context).pop();
                http.post(
                    Uri.parse(
                        "${MyConfig().SERVER}/barterit/php/update_profile.php"), // Need to change
                    body: {
                      "password": _pass1editingController.text,
                      "userid": widget.user.id
                    }).then((response) {
                  var data = jsonDecode(response.body);
                  //  print(data);
                  if (response.statusCode == 200 &&
                      data['status'] == 'success') {
                    Fluttertoast.showToast(
                        msg: "Success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.green,
                        fontSize: 14.0);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.red,
                        fontSize: 14.0);
                  }
                });
              },
            ),
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loadNewCredit() {}
}
