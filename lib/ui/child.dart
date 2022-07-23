import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Location/All.dart';
import 'Location/L.dart';

class Child extends StatefulWidget {
  @override
  _ChildState createState() => _ChildState();
}

class _ChildState extends State<Child> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TabController tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
          title: Padding(
            padding: EdgeInsets.fromLTRB(40, 60, 100, 65),
            child: Image(image: AssetImage('assets/qexpress.png')),
          ),
          backgroundColor: Colors.white,
          elevation: 2.0,
          bottom: PreferredSize(
            preferredSize: Size(400, 150),
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
                      "-   Near 30KM   -",
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
                        text: "Small",
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Tab(
                        text: "Medium",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          All(category: "Child"),
          Large(category: "Child", size: "S"),
          Large(category: "Child", size: "M"),
        ]),
      ),
    );
  }
}
