import 'package:flutter/material.dart';
import 'package:todon/models/note.dart';
import 'package:todon/pages/homepg.dart';
import 'package:todon/pages/notedetails.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Note? note;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "New TODO App Practice",
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        scaffoldBackgroundColor: const Color(0xFF131617),
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}
