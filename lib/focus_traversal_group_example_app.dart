import 'package:flutter/material.dart';

/// A button wrapper that adds either a numerical or lexical order, depending on
/// the type of T
class OrderedButton<T> extends StatefulWidget {
  const OrderedButton({
    super.key,
    required this.name,
    required this.canRequestFocus,
    required this.autofocus,
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
  Widget build(BuildContext context) {
    final FocusOrder order = switch (widget.order) {
      final num number => NumericFocusOrder(number.toDouble()),
      final Object? object => LexicalFocusOrder(object.toString()),
    };
    return FocusTraversalOrder(
      order: order,
      child: Padding(padding: const EdgeInsets.all(8),
        child: OutlinedButton(
          focusNode: focusNode,
            autofocus: widget.autofocus,
            style: ButtonStyle(
              overlayColor:
            ),
            onPressed: onPressed, child: child),
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
        color: Colors.grey,
        child: FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(children: []),
        ),
      ),
    );
  }
}
