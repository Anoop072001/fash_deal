import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
        title: Padding(
          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Text(
            "FashDeal",
            style: GoogleFonts.greatVibes(
                textStyle: TextStyle(fontSize: 40, color: Colors.orange)),
          ),
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: [
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
                    "-   About Us   -",
                    style: GoogleFonts.orbitron(
                      textStyle: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
