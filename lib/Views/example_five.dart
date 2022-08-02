// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/product_model.dart';

class ExampleFive extends StatefulWidget {
  const ExampleFive({Key? key}) : super(key: key);

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  Future<ProductModel> _getProductApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/b5a01d81-e431-4287-acab-81f8ad5ed033'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Complex API"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(
              future: _getProductApi(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: height,
                              width: width,
                              child: ListView.builder(
                                itemCount: snapshot.data.data[index].products.length,
                                itemBuilder: (context, position) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 18.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            child: Text(snapshot.data.data[index].products[position].sold.toString()),
                                          ),
                                          title: Text(snapshot.data.data[index].products[position].title.toString()),
                                          subtitle: Text(snapshot.data.data[index].products[position].description.toString()),
                                        ),
                                        SizedBox(
                                          height: height * 0.2,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data.data[index].products[position].images.length,
                                              itemBuilder: (context,pos){
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Container(
                                                width: width * 0.5,
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: NetworkImage(snapshot.data.data[index].products[position].images![pos].url.toString()),
                                                    fit: BoxFit.cover
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                        Icon(snapshot.data.data[index].products[position].colors == 'Red' ? Icons.favorite_outline : Icons.favorite)
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
