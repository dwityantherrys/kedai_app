import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kedai_app/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditMenu extends StatefulWidget {
  final Map menu;

  EditMenu({@required this.menu});

  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _hargaController = TextEditingController();

  TextEditingController _imageurlController = TextEditingController();

  Future updateMenu() async {
    final response = await http.put(
        Uri.parse('http://192.168.42.12:8000/api/menus' +
            widget.menu['id'].toString()),
        body: {
          "name": _nameController.text,
          "description": _descriptionController.text,
          "harga": _hargaController.text,
          "image_url": _imageurlController.text,
        });
    print(response.body);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent[400],
          title: Text('Edit Menu'),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController..text = widget.menu['name'],
                    decoration: InputDecoration(label: Text('Name')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Fill Name First!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController
                      ..text = widget.menu['description'],
                    decoration: InputDecoration(label: Text('Description')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Fill Description !';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _hargaController..text = widget.menu['harga'],
                    decoration: InputDecoration(label: Text('Harga')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Fill Harga !';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _imageurlController
                      ..text = widget.menu['image_url'],
                    decoration: InputDecoration(label: Text('Image_Url')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Fill Image Url !';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        updateMenu().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Update Data Sukses"),
                          ));
                        });
                      } else {}
                    },
                    child: Text('Update'),
                  )
                ],
              ),
            )));
  }
}
