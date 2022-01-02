import 'dart:convert';

import 'package:flutter/material.dart';
//login

import 'package:http/http.dart' as http;
import 'package:kedai_app/screens/homepage.dart';
import 'package:kedai_app/screens/user.dart';
import 'package:flutter/animation.dart';
import 'package:kedai_app/Animation/FadeAnimation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Multiple Login Flutter",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // variable for saving data from data json which derive from php code in the file login.php
  String username, password, status;

  String alert = "Ready for Login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();

  // method untuk login process
  void loginProcess() async {
    if (_formKey.currentState.validate()) {
      final response = await http
          .post(Uri.parse('http://192.168.42.12:8000/api/login'), body: {
        "username": usernameInput.text,
        "password": passwordInput.text
      });

      var dataUser = json.decode(response.body);

      if (dataUser.length < 1) {
        // if data user is empty or 0
        setState(() {
          alert = "You can't login";
        });
      } else {
        setState(() {});
        if (status == "admin") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        username: username,
                      )));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        username: username,
                      )));
        }
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[800],
          Colors.orange[400]
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Login Page",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: usernameInput,
                                        decoration: InputDecoration(
                                            hintText: "Username",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "Password is empty";
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: passwordInput,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "Password is empty";
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.6,
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.orange[900]),
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Text("Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 50,
                          //height
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
