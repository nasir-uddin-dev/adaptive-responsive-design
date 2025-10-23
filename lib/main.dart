import 'package:flutter/material.dart';
import 'focus_traversal_group_example_app.dart';

void main() {
  runApp(const FocusTraversalGroupExampleApp());
}

class FocusTraversalGroupExampleApp extends StatelessWidget {
  const FocusTraversalGroupExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FocusTraversalGroupExample(),
    );
  }
}

