import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/user.dart';

class BillScreen extends StatefulWidget {
  final User user;
  final int token;
  final String usertoken;
  const BillScreen({super.key, required this.user, required this.token, required this.usertoken});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final df = DateFormat('dd/MM/yyyy');
  late double screenHeight, screenWidth, cardwitdh;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.transparent,
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.all(11),
                    width: screenWidth * 0.4,
                    child: Image.asset(
                      "assets/images/bank.png",
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          const Text(
                            "Barter Company Bank (72345124)",
                            style: TextStyle(fontSize: 20),
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
                            children: const [
                              TableRow(children: [
                                Icon(Icons.email),
                                Text(
                                  "barter24@gmail.com",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ]),
                              TableRow(children: [
                                Icon(Icons.phone),
                                Text(
                                  "016-7231247",
                                ),
                              ]),
                            ],
                          ),
                        ],
                      )),
                ]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 300, 4),
              child: Text(
                "Pay With: ",
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              
              child: const Row(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Online Banking'),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('   E-wallet   '),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('  Credit card '),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 325, 4),
              child: Text(
                "Total ",
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 4, 310, 4),
              child: Text(
                "RM " + widget.token.toString(), style: TextStyle(fontSize: 24)
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {
                  
                }, child: const Text("Successful Payment")),
                ElevatedButton(onPressed: () {
                  
                }, child: const Text("Fail Payment")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
