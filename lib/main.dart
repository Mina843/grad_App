import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  runApp(SmartWheelchairApp());
}

class SmartWheelchairApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Wheelchair',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
