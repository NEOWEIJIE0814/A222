import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/cart.dart';
import '../model/user.dart';
import '../myconfig.dart';

class ContactScreen extends StatefulWidget {
  final User user;
  const ContactScreen({super.key, required this.user});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
    loadcontact();
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
        title: const Text("Contact"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: Column(
        children: [
          cartList.isEmpty
              ? const Center(
              )
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
                                              
                                              const Text("Qty: "),
                                              Text(cartList[index]
                                                  .cartQty
                                                  .toString()),
                                              
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
                              Column(children: [
                                Text(""),
                                Icon(Icons.change_circle),
                                Text(""),
                              ],)
                            ],
                          ),
                        ));
                      })),
        ],
      ),
    );
  }
  
  void loadcontact() {
    // http.post(Uri.parse("${MyConfig().SERVER}/barterit/php/load_request.php"),
    //     body: {
    //       "userid": widget.user.id,
    //     }).then((response) {
    //   print(response.body);
    //   // log(response.body);
    //   cartList.clear();
    //   if (response.statusCode == 200) {
    //     var jsondata = jsonDecode(response.body);
    //     if (jsondata['status'] == "success") {
    //       var extractdata = jsondata['data'];
    //       extractdata['carts'].forEach((v) {
    //         cartList.add(Cart.fromJson(v));
    //       });

    //       cartList.forEach((element) {
    //         totalprice =
    //             totalprice + double.parse(element.cartPrice.toString());
    //       });
    //       //print(catchList[0].catchName);
    //     } else {
    //       Navigator.of(context).pop();
    //     }
    //     setState(() {});
    //   }
    // });
  }
}
