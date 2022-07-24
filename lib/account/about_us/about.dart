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
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                      "-   Customer Query   -",
                      style: GoogleFonts.orbitron(
                        textStyle: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Text(
                      "Got Any problems while surfing?",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.orange,
                        ),
                        Text(
                          "Why Don't you call us?",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.17,
                      child: Text(
                        "Ring at +91 7534******",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Address",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Q-Express,\nNear Christ College of Engineering Irinjalkuda,680121\nThrissur,Kerala\nIndia",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
