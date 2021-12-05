import 'package:flutter/material.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  menu['harga'],
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Icon(Icons.edit),
                    Icon(Icons.delete),
                  ],
                )
              ],
            ),
          ),
          Text(menu['description']),
        ],
      ),
    );
  }
}
