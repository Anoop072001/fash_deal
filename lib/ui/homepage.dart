import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/account/account.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference cref = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser.email);

  String url = "https://www.finlage.in/upi-pay/00003E1";

  @override
  Widget build(BuildContext context) {
    final User _auth = auth.currentUser;
    String _email = _auth.email;
    print(_email);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle_outlined),
          color: Colors.orange,
          iconSize: 40.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Account(),
              ),
            );
          },
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.favorite),
        //       iconSize: 30,
        //       color: Colors.orange,
        //       onPressed: () {})
        // ],
        title: Padding(
          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Text(
            "FashDeal",
            style: GoogleFonts.greatVibes(
                textStyle: TextStyle(fontSize: 40, color: Colors.orange)),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, top: 5),
                child: Container(
                  color: Colors.white.withOpacity(0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                              // width: 50,
                              // height: 50,
                              child: Column(
                                children: [
                                  Container(
                                      width: 30,
                                      height: 30,
                                      child: Image(
                                          image:
                                              AssetImage('assets/shirt.png'))),
                                  Container(
                                      child: Text(
                                    "All",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                              // width: 50,
                              // height: 50,
                              child: Column(
                                children: [
                                  Container(
                                      width: 30,
                                      height: 30,
                                      child: Image(
                                          image:
                                              AssetImage('assets/mens.png'))),
                                  Container(
                                      child: Text(
                                    "Men's",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/men');
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                      width: 30,
                                      height: 30,
                                      child: Image(
                                          image:
                                              AssetImage('assets/womens.png'))),
                                  Container(
                                    child: Text(
                                      "Women's",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/women');
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                              // width: 60,
                              // height: 50,
                              child: Column(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    child: Image(
                                      image: AssetImage('assets/children.png'),
                                    ),
                                  ),
                                  Container(
                                      child: Text(
                                    "Children's",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/child');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                    child: Center(
                      child: Text(
                        "-   Fashion is Life   -",
                        style: GoogleFonts.orbitron(
                          textStyle: TextStyle(fontSize: 35),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: firestore.collection("user").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ListTile(
                              isThreeLine: true,
                              // tileColor: Colors.white,
                              title: Text(
                                document.data()["ItemName"] ?? "No Data",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document.data()["Description"] ?? "No Data",
                                  ),
                                  Text(
                                    document.data()["Size"],
                                  ),
                                ],
                              ),
                              trailing: Container(
                                height: 35,
                                width: 80,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text(
                                      document.data()["Price"] ?? "No Data",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  document.data()["Image"] ??
                                      "https://htmlcolorcodes.com/assets/images/colors/baby-blue-color-solid-background-1920x1080.png",
                                ),
                              ),
                              onTap: () {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      bool fav = false;
                                      String temp = document.data()["ItemName"];
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
                                          document.data()["ItemName"] +
                                                  " - " +
                                                  document.data()["Size"] ??
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
                                                        .data()["Image"])),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 220,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        document
                                                            .data()["Price"],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.orange,
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
                                                          print(fav.toString() +
                                                              temp);
                                                          print(dec);
                                                        } else {
                                                          String temp =
                                                              document.data()[
                                                                  "ItemName"];
                                                          _removeFav(
                                                              _email, temp);
                                                          print("False");
                                                        }
                                                      },
                                                      isFavorite:
                                                          dec ? true : false,
                                                      iconColor: Colors.orange,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  document
                                                      .data()["Description"],
                                                  style: TextStyle(
                                                      color: Colors.orange),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          padding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      85,
                                                                      10,
                                                                      85,
                                                                      10),
                                                          primary:
                                                              Colors.orange),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            padding: EdgeInsets
                                                                .fromLTRB(65,
                                                                    10, 65, 10),
                                                            primary:
                                                                Colors.orange),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ]),
    );
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
