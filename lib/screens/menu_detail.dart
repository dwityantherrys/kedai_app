import 'package:flutter/material.dart';

//menu
class MenuDetail extends StatelessWidget {
  final Map menu;

  MenuDetail({@required this.menu});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent[400],
        title: Text('Detail Menu'),
      ),
      body: Column(
        children: [
          Container(
            child: Image.network(menu['image_url']),
          ),
          SizedBox(
            height: 20,
          ),
          Text(menu['description']),
        ],
      ),
    );
  }
}
