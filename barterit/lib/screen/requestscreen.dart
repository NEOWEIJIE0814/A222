import 'dart:convert';

import 'package:barterit/screen/topuptokenscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/cart.dart';
import '../model/user.dart';
import '../myconfig.dart';

class RequestScreen extends StatefulWidget {
  final User user;

  const RequestScreen({
    super.key,
    required this.user,
  });

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  List<Cart> cartList = <Cart>[];
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  double totalprice = 0.0;
  String itemstatus = "Success";
  int currentindex = 0;
  int barterfees = 2;

  @override
  void initState() {
    super.initState();
    loadcart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request For Barter Item"),
      ),
      body: Column(
        children: [
          cartList.isEmpty
              ? Container()
              : Expanded(
                  child: ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    width: screenWidth / 3,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "${MyConfig().SERVER}/barterit/assets/items/${cartList[index].itemId}.1.png",
                                    placeholder: (context, url) =>
                                        const LinearProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            cartList[index].itemName.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // IconButton(
                                              //     onPressed: () {},
                                              //     icon: const Icon(Icons.remove)),
                                              const Text("Qty: "),
                                              Text(cartList[index]
                                                  .cartQty
                                                  .toString()),
                                              // IconButton(
                                              //   onPressed: () {},
                                              //   icon: const Icon(Icons.add),
                                              // )
                                            ],
                                          ),
                                          Text(
                                              "RM ${double.parse(cartList[index].cartPrice.toString()).toStringAsFixed(2)}")
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    cartList[index].barterStatus.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Divider(
                                color: Colors.blueGrey,
                                thickness: 2.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 170,
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Decline")),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 170,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          currentindex = index;
                                          _comfirmDialog();
                                        },
                                        child: Text("Accept")),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                      })),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //       height: 70,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text("Total Price RM " + totalprice.toStringAsFixed(2)),
          //           ElevatedButton(onPressed: () {}, child: Text("Check Out"))
          //         ],
          //       )),
          // )
        ],
      ),
    );
  }

  void loadcart() {
    http.post(Uri.parse("${MyConfig().SERVER}/barterit/php/load_request.php"),
        body: {
          "userid": widget.user.id,
        }).then((response) {
      print(response.body);
      // log(response.body);
      cartList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['carts'].forEach((v) {
            cartList.add(Cart.fromJson(v));
          });

          cartList.forEach((element) {
            totalprice =
                totalprice + double.parse(element.cartPrice.toString());
          });
          //print(catchList[0].catchName);
        } else {
          Navigator.of(context).pop();
        }
        setState(() {});
      }
    });
  }

  Future<void> _updateStatus() async {
    await http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit/php/update_status.php"), // Need to change
        body: {
          "itemstatus": itemstatus.toString(),
          "cartid": cartList[currentindex].cartid.toString(),
        }).then((response) {
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);

        if (jsondata['status'] == "success") {
          //user = User.fromJson(jsondata['data']);   //error
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Barter Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Barter Fail")));
        }
      }
    }).timeout(const Duration(seconds: 5));
    setState(() {});
  }

  void _comfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Barter the item",
            style: TextStyle(),
          ),
          content: const Text(
              "2 token will be deducted for the processing fees. Are you sure? ",
              style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _updateStatus();
                deductToken();
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
        );
      },
    );
  }

  Future<void> deductToken() async {
    var numtoken = int.tryParse(widget.user.token.toString());  

    if(numtoken! < 2){
      _moreToken();
    }else{
    await http.post(
        Uri.parse(
            "${MyConfig().SERVER}/barterit/php/deduct_token.php"), 
        body: {
          "selecttoken": barterfees.toString(),
          "userid": widget.user.id,
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);

        if (jsondata['status'] == "success") {
         
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Payment Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Payment Fail")));
        }
      }
      setState(() {});
    }).timeout(const Duration(seconds: 5));
    }
  }
  
  void _moreToken() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Your token is not enough",
            style: TextStyle(),
          ),
          content: const Text(
              "Do you want to topup your token ",
              style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => TopUpTokenScreen(
                                  user: widget.user,
                                )));
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
        );
      },
    );
  }
}

