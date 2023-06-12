import 'dart:convert';
import 'dart:developer';

import 'package:barterit/myconfig.dart';
import 'package:barterit/screen/newitemscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/item.dart';
import '../model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OwnerItemScreen extends StatefulWidget {
  final User user;
  const OwnerItemScreen({super.key, required this.user});

  @override
  State<OwnerItemScreen> createState() => _OwnerItemScreenState();
}

class _OwnerItemScreenState extends State<OwnerItemScreen> {
  late double screenWidth, screenHeight;
  late int axiscount = 2;
  late List<Widget> tabchildren;
  String maintitle = "Owner";
  List<Item> itemList = <Item>[];

  @override
  void initState() {
    super.initState();
    loadOwneritem();
    print("Owner");
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
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
      ),
      body: RefreshIndicator(
      onRefresh: () async {
        loadOwneritem();
        },
      child:itemList.isEmpty
          ? const Center(
              child: Text("No data"),
            )
          : 
          Column(
              children: [
                Container(
                  height: 24,
                  alignment: Alignment.center,
                  child: Text(
                    "${itemList.length} item Found",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: axiscount,
                  children: List.generate(itemList.length, (index){
                    return Card(
                      child: InkWell(
                        onLongPress: () {
                          // onDeleteDialog(index);
                        },
                        onTap: () {
                          loadOwneritem();
                        },
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              width: screenWidth,
                              fit: BoxFit.cover,
                              imageUrl: "${MyConfig().SERVER}/barterit/assets/items/${itemList[index].itemId}.1.png",
                              placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                              ),
                              Text(
                                  itemList[index].itemName.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                
                                Text(
                                  itemList[index].itemDesc.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                          ],
                        ),
                      ),
                    );
                  }),
                ))
              ],
            ),),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            

            if (widget.user.id != "na") {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => NewItemScreen(
                            user: widget.user,
                          )));
                          loadOwneritem();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please login/register an account")));
            }
          },
          child: const Text(
            "+",
            style: TextStyle(fontSize: 32),
          )),
    );
  }

  void loadOwneritem() {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/barterit/php/load_item.php"),
        body: {"user_id": widget.user.id}).then((response) {
      //print(response.body);
      log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['item'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }
}
