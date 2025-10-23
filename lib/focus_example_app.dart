import 'package:flutter/material.dart';

class FocusExample extends StatefulWidget {
  const FocusExample({super.key});

  @override
  State<FocusExample> createState() => _FocusExampleState();
}

class _FocusExampleState extends State<FocusExample> {
  @override
  Widget build(BuildContext context) {
    return Focus(child: child);
  }
}
