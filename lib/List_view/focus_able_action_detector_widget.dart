//A widget that combines the functionality of Actions, Shortcuts, MouseRegion
// and a Focus widget to create a detector that defines actions and key bindings,
// and provides callbacks for handling focus and hover highlights.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FadButton extends StatefulWidget {
  const FadButton({super.key, required this.onPressed, required this.child});

  final VoidCallback onPressed;
  final Widget child;

  @override
  State<FadButton> createState() => _FadButtonState();
}

class _FadButtonState extends State<FadButton> {
  bool _focused = false;
  bool _hovering = false;
  bool _on = false;

  late final Map<Type, Action<Intent>> _actionMap;
  final Map<ShortcutActivator, Intent> _shortcutMap = const {
    SingleActivator(LogicalKeyboardKey.keyX): ActivateIntent(),
  };

  @override
  void initState() {
    super.initState();
    _actionMap = {
      ActivateIntent: CallbackAction(
        onInvoke: (Intent intent) => _toggleState(),
      ),
    };
  }

  Color get color {
    Color baseColor = Colors.lightBlue;
    if (_focused) {
      baseColor = Color.alphaBlend(Colors.black.withOpacity(0.25), baseColor);
    }
    if (_hovering) {
      baseColor = Color.alphaBlend(Colors.black.withOpacity(0.1), baseColor);
    }
    return baseColor;
  }

  void _toggleState() {
    setState(() {
      _on = !_on;
    });
  }

  void _handleFocusHighlight(bool value) {
    setState(() {
      _focused = value;
    });
  }

  void _handleHoverHighlight(bool value) {
    setState(() {
      _hovering = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleState,
      child: FocusableActionDetector(
        actions: _actionMap,
        shortcuts: _shortcutMap,
        onShowFocusHighlight: _handleFocusHighlight,
        onShowHoverHighlight: _handleHoverHighlight,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: color,
              child: widget.child,
            ),
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.all(10),
              color: _on ? Colors.red : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class FocusAbleActionDetectorExample extends StatefulWidget {
  const FocusAbleActionDetectorExample({super.key});

  @override
  State<FocusAbleActionDetectorExample> createState() =>
      _FocusAbleActionDetectorExampleState();
}

class _FocusAbleActionDetectorExampleState
    extends State<FocusAbleActionDetectorExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FocusAbleActionDetector Example")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextButton(onPressed: () {}, child: Text('Press Me')),
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: FadButton(onPressed: () {}, child: Text('Add Me')),
            ),
          ],
        ),
      ),
    );
  }
}
