import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/account/account.dart';
import 'package:shopping_app/ui/Location/All.dart';
import 'package:shopping_app/ui/Location/L.dart';

class Ten extends StatefulWidget {
  @override
  _TenState createState() => _TenState();
}

class _TenState extends State<Ten> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TabController tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
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
              Center(
                child: Column(
                  children: [
                    Text(
                      "You are at",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      "Thrissur",
                      style: TextStyle(color: Colors.orange, fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 52,
              ),
              Container(
                width: 100,
                height: 50,
                child: Image(image: AssetImage('assets/qexpress.png')),
              )
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
          bottom: PreferredSize(
            preferredSize: Size(400, 150),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                    child: Center(
                      child: Text(
                        "-   Near 10KM   -",
                        style: GoogleFonts.orbitron(
                          textStyle: TextStyle(fontSize: 35),
                        ),
                      ),
                    ),
                  ),
                  TabBar(
                    labelStyle:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                    controller: tabController,
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.orange,
                    unselectedLabelColor: Theme.of(context).hintColor,
                    tabs: [
                      Container(
                        height: 50,
                        child: Tab(
                          //icon: Image.asset(Constants.kHornIcon),
                          text: "All",
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Tab(
                          text: "MyG",
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Tab(
                          text: "Venus Digital",
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Tab(
                          text: "Elite SM",
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Tab(
                          //icon: Image.asset(Constants.kHornIcon),
                          text: "Kalyan HM",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          All(category: "Men"),
          Large(category: "Men", size: "MyG"),
          Large(category: "Men", size: "Venus Digital"),
          Large(category: "Men", size: "Elite SM"),
          Large(category: "Men", size: "Kalyan HM"),
        ]),
      ),
    );
  }
}
