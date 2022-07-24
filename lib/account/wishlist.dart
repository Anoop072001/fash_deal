import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference cref = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser.email);
  final _email = FirebaseAuth.instance.currentUser.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.orange,
          iconSize: 30.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 50,
              child: Image(image: AssetImage('assets/qexpress.png')),
            )
          ],
        ),
      ),
      body: StreamBuilder(
          stream: cref.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return ListTile(
                      title: Text(
                        document.data().toString().contains("Item")
                            ? document.get("Item")
                            : "no data",
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document.data().toString().contains("Descp")
                                ? document.get("Descp")
                                : "no data",
                          ),
                          Text(
                            document.data().toString().contains("Price")
                                ? document.get("Price")
                                : "no data",
                          ),
                        ],
                      ),
                      trailing: Container(
                        height: 35,
                        width: 80,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Rs.",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                Text(
                                  document.data().toString().contains("Price")
                                      ? document.get("Price")
                                      : "Nodata",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          document.data().toString().contains("Img")
                              ? document.get("Img")
                              : "no data",
                        ),
                      ),
                      onTap: () {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              bool fav = false;
                              String temp =
                                  document.data().toString().contains("Item")
                                      ? document.get("Item")
                                      : "NoData";

                              return AlertDialog(
                                backgroundColor: Colors.black.withOpacity(0.8),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      document
                                              .data()
                                              .toString()
                                              .contains("Item")
                                          ? document.get("Item")
                                          : "no data",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                          color: Colors.orange),
                                    ),
                                  ],
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 220,
                                        width: 220,
                                        color: Colors.black,
                                        child: Image(
                                            image: NetworkImage(
                                                document.get("Img"))),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 220,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Center(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Rs.",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.orange,
                                                        fontSize: 25),
                                                  ),
                                                  Text(
                                                    document
                                                            .data()
                                                            .toString()
                                                            .contains("Price")
                                                        ? document.get("Price")
                                                        : "Nodata",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.orange,
                                                        fontSize: 25),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          document.get("Descp") ?? "no data",
                                          style:
                                              TextStyle(color: Colors.orange),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 70,
                                          width: 260,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.fromLTRB(
                                                    85, 10, 85, 10),
                                                primary: Colors.orange),
                                            onPressed: () {
                                              String url =
                                                  "https://www.finlage.in/upi-pay/0000AV5";
                                              final uri = Uri.parse(url);
                                              if (canLaunchUrl(uri) != false) {
                                                launchUrl(uri);
                                              } else {
                                                print('Could not launch $url');
                                              }
                                            },
                                            child: Text(
                                              "Buy",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 70,
                                          width: 260,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.fromLTRB(
                                                      65, 10, 65, 10),
                                                  primary: Colors.orange),
                                              onPressed: () {
                                                _removeFav(
                                                  _email,
                                                  temp,
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    size: 30.0,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 90,
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          fontSize: 28,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      });
                }).toList(),
              );
            } else {
              return Container();
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          String url = "https://www.finlage.in/upi-pay/0000AV5";
          final uri = Uri.parse(url);
          if (canLaunchUrl(uri) != false) {
            launchUrl(uri);
          } else {
            print('Could not launch $url');
          }
        },
        backgroundColor: Colors.orange,
        icon: Icon(Icons.shopping_cart_checkout),
        label: Text(
          "Buy Now",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  void _removeFav(_email, temp) {
    cref.doc(temp).delete();
  }
}
