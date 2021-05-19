import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Large extends StatefulWidget {
  final String category;
  final String size;

  const Large({Key key, @required this.category, @required this.size})
      : super(key: key);
  @override
  _LargeState createState() => _LargeState(category, size);
}

class _LargeState extends State<Large> {
  final String category;
  final String size;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  _LargeState(this.category, this.size);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: firestore.collection("user").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  shrinkWrap: true,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    if (document.data()["Category"] == category &&
                        document.data()["Size"] == size) {
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
                    } else {
                      return Container();
                    }
                  }).toList(),
                );
              } else {
                return Container();
              }
            }));
  }
}
