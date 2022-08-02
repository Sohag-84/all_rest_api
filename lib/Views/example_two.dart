// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({Key? key}) : super(key: key);

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotosApi() async {
    http.Response response;
    response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos =
            Photos(id: i['id'], title: i['title'], imageUrl: i['url']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api example two"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotosApi(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            snapshot.data![index].imageUrl.toString(),
                          ),
                        ),
                        title: Center(
                          child: Text("Note id: ${snapshot.data![index].id}"),
                        ),
                        subtitle: Text(snapshot.data![index].title.toString()),
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

class Photos {
  String title, imageUrl;
  int id;
  Photos({required this.id, required this.title, required this.imageUrl});
}
