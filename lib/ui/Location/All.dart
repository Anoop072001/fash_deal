import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class All extends StatefulWidget {
  final String category;

  const All({Key key, @required this.category}) : super(key: key);
  @override
  _AllState createState() => _AllState(category);
}

class _AllState extends State<All> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference cref = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser.email);
  final String category;
  bool fav = false;

  _AllState(this.category);
  @override
  Widget build(BuildContext context) {
    final User _auth = auth.currentUser;
    String _email = _auth.email;
    return Scaffold(
      body: StreamBuilder(
          stream: firestore.collection("user").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  if (document.data().toString().contains(category)) {
                    return ListTile(
                        title: Text(
                          document.data().toString().contains("ItemName")
                              ? document.get("ItemName")
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
                              document.data().toString().contains("Description")
                                  ? document.get("Description")
                                  : "no data",
                            ),
                            Text(
                              document.data().toString().contains("Size")
                                  ? document.get("Size")
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
                            document.data().toString().contains("Image")
                                ? document.get("Image")
                                : "no data",
                          ),
                        ),
                        onTap: () {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                String temp = document
                                        .data()
                                        .toString()
                                        .contains("ItemName")
                                    ? document.get("ItemName")
                                    : "NoData";

                                return AlertDialog(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.8),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        document
                                                .data()
                                                .toString()
                                                .contains("ItemName")
                                            ? document.get("ItemName")
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
                                                  document.get("Image"))),
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
                                                      // document.data()["Price"] ??
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
                                                          ? document
                                                              .get("Price")
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
                                              FavoriteButton(
                                                valueChanged: (fav) {
                                                  setState(() {
                                                    // print("changed");
                                                    fav = fav;
                                                    print(fav);
                                                  });
                                                  if (fav == true) {
                                                    String temp = document
                                                        .get("ItemName");
                                                    String temp1 = document
                                                        .get("Description");
                                                    String temp2 =
                                                        document.get("Price");
                                                    String temp3 =
                                                        document.get("Image");

                                                    _addFav(_email, temp, temp1,
                                                        temp2, temp3);
                                                    print(
                                                        fav.toString() + temp);
                                                    // print(dec);
                                                  } else {
                                                    _removeFav(
                                                      _email,
                                                      temp,
                                                    );
                                                    print("False");
                                                  }
                                                },
                                                isFavorite: fav ? true : false,
                                                iconColor: Colors.orange,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            document.get("Description") ??
                                                "no data",
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
    );
  }

  void _launchURL() async {
    String url = "https://www.finlage.in/upi-pay/0000AV5";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void _addFav(_email, temp, temp1, temp2, temp3) {
    cref.doc(temp).set({
      "fav": true,
      "Item": temp,
      "Descp": temp1,
      "Price": temp2,
      "Img": temp3
    });
  }

  void _removeFav(_email, temp) {
    cref.doc(temp).delete();
  }
}
