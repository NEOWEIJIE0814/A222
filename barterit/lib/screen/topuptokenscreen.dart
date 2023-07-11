import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/user.dart';
import '../myconfig.dart';
import 'billscreen.dart';

class TopUpTokenScreen extends StatefulWidget {
  final User user;
  const TopUpTokenScreen({super.key, required this.user,});

  @override
  State<TopUpTokenScreen> createState() => _TopUpTokenScreenState();
}

class _TopUpTokenScreenState extends State<TopUpTokenScreen> {
  late double screenHeight, screenWidth, resWidth;
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  int val = -1;
  List<String> creditType = ["5", "10", "15", "20", "25", "50", "100", "1000"];
  String selectedValue = "5";
  double price = 0.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Up Your Barter Token"),
        //backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: screenHeight * 0.25,
              width: screenWidth,
              child: Card(
                elevation: 10,
                child: Column(
                  children: [
                    Text(
                      widget.user.name.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
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
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Card(
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: screenWidth,
                    height: screenHeight * 0.38,
                    child: Column(
                      children: [
                        const Text("BUY BARTER TOKEN (1 Token = Rm 1)",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Divider(
                            color: Colors.blueGrey,
                            height: 1,
                            thickness: 2.0,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Select Barter Token",
                          style: TextStyle(fontSize: 16),
                        ),
                        const Divider(
                          color: Colors.blueGrey,
                          height: 2,
                          indent: 125,
                          endIndent: 135,
                          thickness: 1.0,
                        ),
                        SizedBox(
                          height: 60,
                          width: 100,
                          child: DropdownButton(
                            isExpanded: true,
                            //sorting dropdownoption
                            hint: const Text(
                              'Please select Barter Token',
                              style: TextStyle(
                                color: Color.fromRGBO(101, 255, 218, 50),
                              ),
                            ), // Not necessary for Option 1
                            value: selectedValue,
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue.toString();
                                // print(selectedValue);
                              });
                            },
                            items: creditType.map((selectedValue) {
                              return DropdownMenuItem(
                                child: Text(selectedValue,
                                    style: const TextStyle()),
                                value: selectedValue,
                              );
                            }).toList(),
                          ),
                        ),
                        const Divider(
                          color: Colors.blueGrey,
                          height: 0,
                          indent: 125,
                          endIndent: 135,
                          thickness: 1.0,
                        ),
                        const SizedBox(height: 10),
                        Text(
                            "RM " +
                                double.parse(selectedValue).toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          child: const Text("BUY", style: TextStyle(fontSize: 20),),
                          onPressed: _buyTokenDialog,
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(screenWidth / 2, 50)),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _buyTokenDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(
            "Buy Token RM " +
                double.parse(selectedValue).toStringAsFixed(2) +
                "?",
            style: const TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle(fontSize: 16)),
          actions: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: const Text(
                    "Yes",
                    style: TextStyle(),
                  ),
                  onPressed: () async {
                Navigator.of(context).pop();
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => BillScreen(
                                  user: widget.user,
                                   token: int.parse(selectedValue),            //#need to add
                                   usertoken: widget.user.token.toString(),
                                )));
                     _loadNewToken();
                  },
                ),
              
            TextButton(
              child: const Text(
                "No",
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
  
  void _loadNewToken() {
    http.post(Uri.parse("${MyConfig().SERVER}/barterit/php/update_profile.php"), //loaduser need to change
        body: {"email": widget.user.email}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        final jsonResponse = json.decode(response.body);
        //print(response.body);
        User user = User.fromJson(jsonResponse);
        setState(() {
        });
      }
    });
  }
  }

