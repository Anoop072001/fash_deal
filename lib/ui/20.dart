import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/ui/Location/All.dart';

import 'Location/L.dart';

class Twenty extends StatefulWidget {
  @override
  _TwentyState createState() => _TwentyState();
}

class _TwentyState extends State<Twenty> {
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
                      "-   Near 20KM   -",
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
                        text: "BISMI HP",
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Tab(
                        text: "Pittapilli",
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Tab(
                        text: "McD",
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Tab(
                        //icon: Image.asset(Constants.kHornIcon),
                        text: "GFootwear",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          All(category: "20"),
          Large(category: "20", size: "BISMI HP"),
          Large(category: "20", size: "Pittapilli"),
          Large(category: "20", size: "McD"),
          Large(category: "20", size: "GFootwear"),
        ]),
      ),
    );
  }
}
