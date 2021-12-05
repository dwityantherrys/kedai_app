import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kedai_app/screens/add_menu.dart';
import 'package:kedai_app/screens/edit_menu.dart';
import 'package:kedai_app/screens/menu_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'http://192.168.42.12:8000/api/menus';

  Future getMenus() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteMenu(String menuId) async {
    final String url =
        'http://192.168.42.12:8000/api/menus' + menuId.toString();

    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddMenu()));
          },
          child: Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          title: Text('Kedai Makanan'),
          backgroundColor: Colors.amberAccent[400],
        ),
        body: FutureBuilder(
          future: getMenus(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.amberAccent,
                      height: 180,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuDetail(
                                                menu: snapshot.data['data']
                                                    [index],
                                              )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  height: 120,
                                  width: 120,
                                  child: Image.network(snapshot.data['data']
                                      [index]['image_url']),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot.data['data'][index]['name'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(snapshot.data['data'][index]
                                            ['description']),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    EditMenu(
                                                                      menu: snapshot
                                                                              .data['data']
                                                                          [
                                                                          index],
                                                                    )));
                                                  },
                                                  child: Icon(Icons.edit)),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      deleteMenu(snapshot
                                                              .data['data']
                                                                  [index]['id']
                                                              .toString())
                                                          .then((value) {
                                                        setState(() {});
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Menu Berhasil Di hapus"),
                                                        ));
                                                      });
                                                    },
                                                    child: Icon(Icons.delete)),
                                              ),
                                            ],
                                          ),
                                          Text(snapshot.data['data'][index]
                                              ['harga']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Text(
                'Loading...',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              );
            }
          },
        ));
  }
}
