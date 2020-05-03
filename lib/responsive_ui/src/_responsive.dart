import 'package:flutter/material.dart';

import './_div.dart';

enum _Screen { SMALL, MEDIUM, LARGE }

class Responsive extends StatelessWidget {
  Responsive({
    @required this.children,
    this.defaultColS = 12,
    this.defaultColM,
    this.defaultColL,
    this.runSpacing = 0.0,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
  })  : assert(children != null, "children shoud not be Null"),
        assert(defaultColS == null || (defaultColS >= 0 && defaultColS <= 12)),
        assert(defaultColM == null || (defaultColM >= 0 && defaultColM <= 12)),
        assert(defaultColL == null || (defaultColL >= 0 && defaultColL <= 12));
  final key = Key('fg');

  final List<Widget> children;

  final int defaultColS;
  final int defaultColM;
  final int defaultColL;

  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final WrapCrossAlignment crossAxisAlignment;
  final double runSpacing;

  final double _widthMobile = 600.0;
  final double _widthTab = 990;

  int col = 0;
  _Screen currentScreen;
  void _setCurrentScreen(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < _widthMobile) {
      currentScreen = _Screen.SMALL;
      col = defaultColS;
    } else if (width < _widthTab) {
      currentScreen = _Screen.MEDIUM;
      col = defaultColM ?? defaultColS;
    } else {
      currentScreen = _Screen.LARGE;
      col = defaultColL ?? defaultColM ?? defaultColS;
    }
  }

  @override
  Widget build(BuildContext context) {
    _setCurrentScreen(context);
    return Wrap(
      alignment: alignment,
      runSpacing: runSpacing,
      children: _generateWidget(),
      runAlignment: runAlignment,
      crossAxisAlignment: crossAxisAlignment,
    );
  }

  List<Widget> _generateWidget() {
    final List<Widget> rChildren = [];
    for (Widget child in children) {
      if (child.toString() == 'Div') {
        Div div = child;
        rChildren.add(_createDivWidget(div));
      } else {
        rChildren.add(_createNormalWidget(child));
      }
    }
    return rChildren;
  }

  Widget _createNormalWidget(Widget child) {
    return LayoutBuilder(builder: (ctx, box) {
      double width = (box.maxWidth / 12) * col;
      return width == 0
          ? SizedBox.shrink()
          : SizedBox(width: width, child: child);
    });
  }

  Widget _createDivWidget(Div div) {
    return LayoutBuilder(builder: (ctx, box) {
      int divFullCol = 0;
      int divCol = 0;

      if (currentScreen == _Screen.SMALL) {
        divCol = div.colS;
        divFullCol = (div.offsetS + divCol >= 12) ? 12 : div.offsetS + divCol;
      } else if (currentScreen == _Screen.MEDIUM) {
        divCol = div.colM ?? div.colS;
        divFullCol = (div.offsetM + divCol >= 12) ? 12 : div.offsetM + divCol;
      } else {
        divCol = div.colL ?? div.colM ?? div.colS;
        divFullCol = (div.offsetL + divCol >= 12) ? 12 : div.offsetL + divCol;
      }
      double width = (box.maxWidth / 12) * divFullCol;
      return width == 0
          ? SizedBox.shrink()
          : SizedBox(
              width: width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: (box.maxWidth / 12) * divCol, child: div),
                ],
              ),
            );
    });
  }
}
