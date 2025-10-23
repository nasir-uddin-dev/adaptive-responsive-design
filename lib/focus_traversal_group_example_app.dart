import 'package:flutter/material.dart';

/// A button wrapper that adds either a numerical or lexical order, depending on
/// the type of T
class OrderedButton<T> extends StatefulWidget {
  const OrderedButton({
    super.key,
    required this.name,
    this.canRequestFocus = true,
    this.autofocus = false,
    required this.order,
  });

  final String name;
  final bool canRequestFocus;
  final bool autofocus;
  final T order;

  @override
  State<OrderedButton> createState() => _OrderedButtonState();
}

class _OrderedButtonState extends State<OrderedButton> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode(
      debugLabel: widget.name,
      canRequestFocus: widget.canRequestFocus,
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant OrderedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    focusNode.canRequestFocus = widget.canRequestFocus;
  }

  void _handleOnPressed() {
    focusNode.requestFocus();
    debugPrint("Button ${widget.name} pressed");
    debugDumpFocusTree();
  }

  @override
  Widget build(BuildContext context) {
    final FocusOrder order = switch (widget.order) {
      final num number => NumericFocusOrder(number.toDouble()),
      final Object? object => LexicalFocusOrder(object.toString()),
    };
    return FocusTraversalOrder(
      order: order,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: OutlinedButton(
          focusNode: focusNode,
          autofocus: widget.autofocus,
          style: ButtonStyle(
            overlayColor: WidgetStateProperty<Color?>.fromMap(
              /// If neither of these states is active, the property will resolve
              /// to null, deferring to the default overlay color.
              {
                WidgetState.focused: Colors.red,
                WidgetState.hovered: Colors.blue,
              },
            ),
            foregroundColor: WidgetStateProperty<Color?>.fromMap(
              ///WidgetState.focused | WidgetState.hovered could be used instead
              ///of separate map keys, but this setup allows setting the button
              ///style to a constant value for improved efficiency.
              {
                WidgetState.focused: Colors.white,
                WidgetState.hovered: Colors.white,
              },
            ),
          ),
          onPressed: () => _handleOnPressed(),
          child: Text(widget.name),
        ),
      ),
    );
  }
}

class FocusTraversalGroupExample extends StatefulWidget {
  const FocusTraversalGroupExample({super.key});

  @override
  State<FocusTraversalGroupExample> createState() =>
      _FocusTraversalGroupExampleState();
}

class _FocusTraversalGroupExampleState
    extends State<FocusTraversalGroupExample> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///A group that is ordered with a numerical order, from left to right.
              FocusTraversalGroup(
                policy: OrderedTraversalPolicy(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(3, (int index) {
                    return OrderedButton(
                      name: 'num $index',

                      ///Try this : change this to "3 - index" and see how the
                      ///order changes.
                      order: index,
                    );
                  }),
                ),
              ),

              ///A group that is ordered with a lexical order, from right to left.
              FocusTraversalGroup(
                policy: OrderedTraversalPolicy(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(3, (int index) {
                    /// Order as "C", "B" "A"
                    final String order = String.fromCharCode(
                      'A'.codeUnitAt(0) + (2 - index),
                    );
                    return OrderedButton(name: 'String : $order', order: order);
                  }),
                ),
              ),

              ///A group that orders in widget order, regardless of what the order
              ///is set to
              FocusTraversalGroup(
                ///Because this is NOT an OrderedTraversalPolicy, the assigned
                ///order of these OrderedButtons is ignored, and they are traversed
                ///in widget order. TRY THIS : chang this to "OrderedTraversalPolicy()"
                ///and see that it now follows the numeric order set on them instead
                ///of the widget order
                policy: WidgetOrderTraversalPolicy(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(3, (int index) {
                    return OrderedButton<num>(
                      name: "ignored num: ${3 - index}",
                      order: 3 - index,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
