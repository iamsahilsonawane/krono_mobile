import 'package:flutter/material.dart';

class FocusWidget extends StatefulWidget {
  final Widget child;
  final bool? autofocus;
  final Function(bool hasFocus)? hasFocus;
  final Function(RawKeyEvent event) event;
  final FocusNode? customFocusNode;

  const FocusWidget({
    Key? key,
    required this.child,
    required this.event,
    this.autofocus,
    this.hasFocus,
    this.customFocusNode,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FocusWidgetState createState() => _FocusWidgetState();
}

class _FocusWidgetState extends State<FocusWidget> {
  final FocusNode fn = FocusNode();

  void listener() {
    widget.hasFocus?.call(widget.customFocusNode?.hasFocus ?? fn.hasFocus);
  }

  FocusNode get _primaryFocusNode => (widget.customFocusNode ?? fn);

  @override
  void initState() {
    super.initState();
    _primaryFocusNode.addListener(listener);
  }

  @override
  void dispose() {
    _primaryFocusNode.removeListener(listener);
    _primaryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: widget.autofocus ?? false,
      focusNode: widget.customFocusNode ?? fn,
      onKey: (event) {
        widget.event.call(event);
      },
      child: widget.child,
    );
  }
}
