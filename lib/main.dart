import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/account/about_us/about.dart';
import 'package:shopping_app/account/account.dart';
import 'package:shopping_app/account/wishlist.dart';
import 'package:shopping_app/ui/30.dart';
import 'package:shopping_app/ui/homepage.dart';
import 'package:shopping_app/ui/authentication.dart';
import 'package:shopping_app/ui/10.dart';
import 'package:shopping_app/ui/20.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => MyApp(),
      '/home': (context) => HomePage(),
      '/men': (context) => Ten(),
      '/women': (context) => Twenty(),
      '/account': (context) => Account(),
      '/child': (context) => Thirty(),
      '/about': (context) => About(),
      '/cart': (context) => Cart(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Authentication(),
    );
  }
}
