import 'package:flutter/material.dart';
import 'package:shopping_app/account/account.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/double-bubble-outline.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Column(
                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              child:
                                  Image(image: AssetImage('assets/shirt.png'))),
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
                      width: 50,
                      height: 50,
                      child: Column(
                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              child:
                                  Image(image: AssetImage('assets/mens.png'))),
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
                      print("Clicked 1");
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
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
                      print("Clicked 2");
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      width: 60,
                      height: 50,
                      child: Column(
                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              child:
                                  Image(image: AssetImage('assets/shoe.png'))),
                          Container(
                              child: Text(
                            "FootWear",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          )),
                        ],
                      ),
                    ),
                    onTap: () {
                      print("Clicked 3");
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  child: Text(
                    "Fashion \nis Life",
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
