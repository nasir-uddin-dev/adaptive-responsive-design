import 'package:flutter/material.dart';

class ListenerApp extends StatelessWidget {
  ListenerApp({super.key});

  final List<String> entries = ['A', 'B', 'c'];
  final List<int> colorCodes = [600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Listener Example')),
        body: Center(child: ListenerExample()),
      ),
    );
  }
}

class ListenerExample extends StatefulWidget {
  const ListenerExample({super.key});

  @override
  State<ListenerExample> createState() => _ListenerExampleState();
}

class _ListenerExampleState extends State<ListenerExample> {
  int _downCounter = 0;
  int _upCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementDown(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _downCounter++;
    });
  }

  void _incrementUp(PointerEvent details) {
    _updateLocation(details);
    setState(() {
      _upCounter++;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(300, 200)),
      child: Listener(
        onPointerDown: _incrementDown,
        onPointerMove: _updateLocation,
        onPointerUp: _incrementUp,
        child: ColoredBox(
          color: Colors.lightBlueAccent,
          child: Column(
            children: [
              const Text("You have pressed or release in this area many times"),
              Text(
                "$_downCounter presses\n$_upCounter releases",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 10,),
              Text(
                "The cursor is here : (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}) ",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
