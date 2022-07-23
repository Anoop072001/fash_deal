import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Large extends StatefulWidget {
  final String category;
  final String size;

  const Large({Key key, @required this.category, @required this.size})
      : super(key: key);
  @override
  _LargeState createState() => _LargeState(category, size);
}

class _LargeState extends State<Large> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String category;
  final String size;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference cref = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser.email);

  String url = "https://www.finlage.in/upi-pay/00003E1";

  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  _LargeState(this.category, this.size);
  @override
  Widget build(BuildContext context) {
    final User _auth = auth.currentUser;
    String _email = _auth.email;
    return Scaffold(
        body: SingleChildScrollView(
      child: StreamBuilder(
          stream: firestore.collection("user").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  // if (document.data()["Category"] == category &&
                  //     document.data()["Size"] == size) {
                  if (document.data() == category && document.data() == size) {
                    return ListTile(
                        title: Text(
                          document.data(),
                          // document.data()["ItemName"],

                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                        subtitle:
                            // Text(document.data()["Description"] ?? "No Data"),
                            Text(document.data() ?? "No Data"),
                        // trailing: Text(document.data()["Price"] ?? "No Data"),
                        trailing: Text(document.data() ?? "No Data"),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            // document.data()["Image"] ?? "No Data",
                            document.data() ?? "No Data",
                          ),
                        ),
                        onTap: () {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                bool fav = false;
                                // String temp = document.data()["ItemName"];
                                String temp = document.data();

                                bool dec = true;
                                var deca = FirebaseFirestore.instance
                                    .collection(_email)
                                    .doc(temp)
                                    .get()
                                    .then((doc) {
                                  if (doc.data()["fav"] == true) {
                                    setState(() {
                                      dec = true;
                                    });
                                    print(dec);
                                  } else if (doc.data()["fav"] == false) {
                                    setState(() {
                                      dec = false;
                                    });
                                    print(dec);
                                  }
                                });

                                return AlertDialog(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.8),
                                  title: Text(
                                    // document.data()["ItemName"] +
                                    //         " - " +
                                    //         document.data()["Size"] ??
                                    "No Data",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.orange),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 220,
                                          width: 220,
                                          color: Colors.black,
                                          child: Image(
                                              image: NetworkImage(document
                                                      // .data()["Image"] ??
                                                      .data() ??
                                                  "https://htmlcolorcodes.com/assets/images/colors/baby-blue-color-solid-background-1920x1080.png")),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 220,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Center(
                                                child: Text(
                                                  // document.data()["Price"] ??
                                                  document.data() ?? "no data",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.orange,
                                                      fontSize: 25),
                                                ),
                                              ),
                                              FavoriteButton(
                                                valueChanged: (fav) {
                                                  setState(() {
                                                    //fav = !fav;
                                                  });
                                                  if (fav = true) {
                                                    _addFav(_email, temp);
                                                    print(
                                                        fav.toString() + temp);
                                                    print(dec);
                                                  } else {
                                                    String temp =
                                                        document.data();
                                                    // .data()["ItemName"];

                                                    _removeFav(_email, temp);
                                                    print("False");
                                                  }
                                                },
                                                isFavorite: dec ? true : false,
                                                iconColor: Colors.orange,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            document.data(),
                                            // document.data()["Description"],

                                            style:
                                                TextStyle(color: Colors.orange),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.fromLTRB(
                                                    85, 10, 85, 10),
                                                primary: Colors.orange),
                                            onPressed: () {
                                              _launchURL();
                                            },
                                            child: Text(
                                              "Buy",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.fromLTRB(
                                                      65, 10, 65, 10),
                                                  primary: Colors.orange),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.black),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        });
                  } else {
                    return Container();
                  }
                }).toList(),
              );
            } else {
              return Container();
            }
          }),
    ));
  }

  void _launchURL() async {
    String url = "https://www.finlage.in/upi-pay/00003E1";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void _addFav(_email, temp) {
    cref.doc(temp).set({
      "fav": true,
      "Item": temp,
    });
  }

  void _removeFav(_email, temp) {
    cref.doc(temp).set({
      "fav": false,
    });
  }
}
