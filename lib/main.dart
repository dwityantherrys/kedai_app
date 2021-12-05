import 'package:flutter/material.dart';
import 'package:kedai_app/screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Kedai Makanan', home: HomePage());
  }
}
