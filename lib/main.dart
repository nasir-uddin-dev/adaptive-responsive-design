import 'package:flutter/material.dart';
import 'focus_example_app_2.dart';


void main() {
  runApp(const FocusExampleApp());
}

class FocusExampleApp extends StatelessWidget {
  const FocusExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Focus Example"),),
        body: FocusAbleText(),
      ),
    );
  }
}

