import '../responsive_ui/responsive_ui.dart';
import 'package:flutter/material.dart';

import 'generate.dart';

class RespoEx extends StatelessWidget {
  const RespoEx({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive UI Example'),
        centerTitle: true,
      ),
      body: Responsive(
        defaultColS: 6,
        children: <Widget>[
          Div(
            colS: 3,
            child: Card(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
