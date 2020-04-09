import 'package:flutter/material.dart';
import 'package:jianshu/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '简书',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color(0xfff5f5f5),
        primaryColor: Color(0xffea6f5a)
      ),
      home: HomePage(),
    );
  }
}
