// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/Views/example_three.dart';

//fetch data without creating model class

class ExampleFour extends StatelessWidget {
  ExampleFour({Key? key}) : super(key: key);

  var data;

  Future<void> _getUserApi() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example Four"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _getUserApi(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Container(
                          color: Colors.green,
                          child: Column(
                            children: [
                              ReusableRow(
                                title: 'Name',
                                value: data[index]['name'].toString(),
                              ),
                              ReusableRow(
                                title: 'Email',
                                //0.name
                                value: data[index]['email'].toString(),
                              ),
                              ReusableRow(
                                title: 'City',
                                value: data[index]['address']['city'].toString(),
                              ),
                              ReusableRow(
                                title: 'Geo',
                                //0.address.geo.lat
                                value: data[index]['address']['geo'].toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
