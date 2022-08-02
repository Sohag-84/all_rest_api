// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

import '../Models/user_model.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatelessWidget {
  ExampleThree({Key? key}) : super(key: key);

  final List<UserModel> _userList = [];

  Future<List<UserModel>> _getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        print(i['name']);
        _userList.add(UserModel.fromJson(i));
      }
      return _userList;
    }
    return _userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example Three"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _getUserApi(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: _userList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.orange,
                              child: Column(
                                children: [
                                  ReusableRow(
                                    title: 'Name',
                                    value:
                                        snapshot.data![index].name.toString(),
                                  ),
                                  SizedBox(height: 5),
                                  ReusableRow(
                                    title: 'Mobile',
                                    value:
                                        snapshot.data![index].phone.toString(),
                                  ),
                                  SizedBox(height: 5),
                                  ReusableRow(
                                    title: 'Email',
                                    value:
                                        snapshot.data![index].email.toString(),
                                  ),
                                  SizedBox(height: 5),
                                  ReusableRow(
                                    title: 'Address',
                                    value: snapshot.data![index].address!.city
                                        .toString(),
                                  ),
                                  SizedBox(height: 5),
                                  ReusableRow(
                                    title: 'Geo',
                                    value: snapshot
                                        .data![index].address!.geo!.lat
                                        .toString(),
                                  ),
                                  SizedBox(height: 5),
                                  ReusableRow(
                                    title: 'Company Name',
                                    value: snapshot.data![index].company!.name
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
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

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
