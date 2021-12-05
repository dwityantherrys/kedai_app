import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kedai_app/screens/homepage.dart';
import 'package:http/http.dart' as http;

class AddMenu extends StatefulWidget {
  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _hargaController = TextEditingController();

  TextEditingController _imageurlController = TextEditingController();

  Future saveMenu() async {
    final response = await http
        .post(Uri.parse('http://192.168.42.12:8000/api/menus'), body: {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "harga": _hargaController.text,
      "image_url": _imageurlController.text,
    });

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent[400],
          title: Text('Add Menu'),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(label: Text('Name')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Fill Name First!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(label: Text('Description')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Fill Description !';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _hargaController,
                    decoration: InputDecoration(label: Text('Harga')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Fill Harga !';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _imageurlController,
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
                        saveMenu().then((value) {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Tambah Data Sukses"),
                          ));
                        });
                      } else {}
                    },
                    child: Text('Save'),
                  )
                ],
              ),
            )));
  }
}
