import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kedai_app/screens/homepage.dart';
import 'package:kedai_app/screens/user.dart';

import '../main.dart';

class CekKeranjang extends StatefulWidget {
  final String username;

  CekKeranjang({this.username});
  @override
  _CekKeranjangState createState() => _CekKeranjangState();
}

class _CekKeranjangState extends State<CekKeranjang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.orange[900],
        overlayOpacity: 0.5,
        overlayColor: Colors.black,
        children: [
          SpeedDialChild(
            child: Icon(Icons.shopping_basket_rounded),
            label: 'Pesan Sekarang',
            onTap: () {
              Navigator.push(
                      context, MaterialPageRoute(builder: (context) => User()))
                  .then((value) {
                setState(() {});
              });
            },
          ),
          SpeedDialChild(
              child: Icon(Icons.backspace),
              backgroundColor: Colors.red,
              label: 'Kembali',
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => User()));
              }),
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("User"),
              SizedBox(
                height: 20,
              ),
              Text("Welcome : ${widget.username}"),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
