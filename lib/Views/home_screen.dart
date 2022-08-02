// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rest_api/Views/example_five.dart';
import 'package:rest_api/Views/example_fout.dart';
import 'package:rest_api/Views/example_three.dart';
import 'package:rest_api/Views/example_two.dart';
import 'package:rest_api/Views/exaple_one.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ExampleOne(),
              ),
            );
          },
          child: Text("Example One"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ExampleTwo(),
              ),
            );
          },
          child: Text("Example Two"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExampleThree(),
            ),
          ),
          child: Text("Example Three"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExampleFour(),
            ),
          ),
          child: Text("Example Four"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ExampleFive(),
              ),
            );
          },
          child: Text("Example Five"),
        ),
      ],
    );
  }
}
