import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  runApp(const SmartWheelchairApp());
}

class SmartWheelchairApp extends StatelessWidget {
  const SmartWheelchairApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Wheelchair',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}
