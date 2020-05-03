import 'package:eg_resp_ui/responsive_ui/responsive_ui.dart';
import 'package:flutter/material.dart';

class GenerateWidget extends StatefulWidget {
  @override
  _GenerateWidgetState createState() => _GenerateWidgetState();
}

class _GenerateWidgetState extends State<GenerateWidget> {
  @override
  Widget build(BuildContext context) {
    return Div(
      child: Card(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
