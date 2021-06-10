import 'package:flutter/material.dart';
import 'package:flutter_task/home.dart';
import 'package:flutter_task/screens/poland_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
        routes: {
          '/poland': (context) => PolandMap(),
        });
  }
}
