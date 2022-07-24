import 'package:flutter/material.dart';
import 'package:shopping_app/net/flutterfire.dart';
import 'package:shopping_app/ui/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.orange,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 60.0),
                child: Center(
                  child: Image(image: AssetImage('assets/qexpress.png')),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextFormField(
                    validator: (val) => val.isEmpty || !(val.contains('@'))
                        ? "Enter a valid email address"
                        : null,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _emailField,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      hintText: "something@gmail.com",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: _passwordField,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    filled: true,
                    hintText: "password",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  validator: (value) =>
                      value.isEmpty ? "Enter a valid password" : null,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNAvigate =
                        await register(_emailField.text, _passwordField.text);
                    if (shouldNAvigate) {
                      Navigator.pushNamed(context, '/home');
                    } else {
                      final loginerror = SnackBar(
                          backgroundColor: Colors.black,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "User already exists",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 17),
                              ),
                            ],
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(loginerror);
                    }
                  },
                  child: Text("Register"),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      bool shouldNAvigate =
                          await signIn(_emailField.text, _passwordField.text);
                      if (shouldNAvigate) {
                        Navigator.pushNamed(context, '/home');
                      } else {
                        final loginerror = SnackBar(
                            backgroundColor: Colors.black,
                            content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Username or Password is Wrong!!",
                                    style: TextStyle(
                                        color: Colors.orange, fontSize: 17),
                                  )
                                ]));
                        ScaffoldMessenger.of(context).showSnackBar(loginerror);
                      }
                    }
                  },
                  child: Text("Log in"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
