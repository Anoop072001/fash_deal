import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/account/account.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
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
        title: Padding(
          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Text(
            "FashDeal",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
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
                                    image: AssetImage('assets/shirt.png'))),
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
                      onTap: () {
                        print("Clicked");
                      },
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
                                    image: AssetImage('assets/mens.png'))),
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
                        // width: 50,
                        // height: 50,
                        child: Column(
                          children: [
                            Container(
                                width: 30,
                                height: 30,
                                child: Image(
                                    image: AssetImage('assets/womens.png'))),
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
                                    image: AssetImage('assets/children.png'))),
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
                      "Fashion is Life",
                      style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
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
                      return ListTile(
                        title: Text(
                          document.data()["ItemName"],
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                        subtitle:
                            Text(document.data()["Description"] ?? "No Data"),
                        trailing: Text(document.data()["Price"] ?? "No Data"),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            document.data()["Image"] ?? "No Data",
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Container();
                }
              },
            )
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     height: 30,
            //     width: 30,
            //     color: Colors.black,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
