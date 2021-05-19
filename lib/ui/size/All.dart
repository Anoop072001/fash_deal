import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class All extends StatefulWidget {
  final String category;

  const All({Key key, @required this.category}) : super(key: key);
  @override
  _AllState createState() => _AllState(category);
}

class _AllState extends State<All> {
  final String category;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  _AllState(this.category);
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
                    if (document.data()["Category"] == category) {
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
