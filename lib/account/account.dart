import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/account/about_us/about.dart';
import 'package:shopping_app/account/wishlist/wishlist.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
            Navigator.of(context).pop();
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
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.png'),
              radius: 40.0,
              backgroundColor: Colors.orange,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "My Account",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => Wishlist(),
          //         ));
          //   },
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: 50,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10.0),
          //       color: Colors.orange,
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(
          //           Icons.favorite,
          //           color: Colors.white,
          //         ),
          //         Center(
          //           child: Text(
          //             " Wishlist",
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.orange,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  Center(
                    child: Text(
                      " About Us",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
