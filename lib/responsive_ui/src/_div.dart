import 'package:flutter/material.dart';

class Div extends StatelessWidget {
  final Widget child;

  /// Small screen `< 600.0`
  ///
  /// input range [0 -12]
  ///
  /// `0` ~ 0.0 width / gone
  ///i
  /// `12` ~ full width
  ///
  /// default `12`
  final int colS;

  /// Medium screen `600.0 to 990.0`
  ///
  /// input range [0 -12]
  ///
  /// `0` ~ 0.0 width / gone
  ///
  /// `12` ~ full width
  ///
  /// `null` / `default` ~ takes [ColS] value
  final int colM;

  /// Large screen `> 990`
  ///
  /// input range [0 -12]
  ///
  /// `0` ~ 0.0 width / gone
  ///
  /// `12` ~ full width
  ///
  /// `null` / `default` ~  takes [ColM] value
  final int colL;

  /// input range [0 -12]
  ///
  /// default `0`
  final int offsetS;

  /// input range [0 -12]
  ///
  /// default `0`
  final int offsetM;

  /// input range [0 -12]
  ///
  /// default `0`
  final int offsetL;

  final double _widthMobile = 600.0;

  final double _widthTab = 990;

  /// use it as `DIRECT CHILD` inside `Responsive()` to render ui as better expected
  Div(
      {this.colS = 12,
      this.colM,
      this.colL,
      @required this.child,
      this.offsetS = 0,
      this.offsetM = 0,
      this.offsetL = 0})
      : assert(child != null, "child shoud not be Null"),
        assert(colS == null || (colS >= 0 && colS <= 12)),
        assert(colM == null || (colM >= 0 && colM <= 12)),
        assert(colL == null || (colL >= 0 && colL <= 12)),
        assert(offsetS >= 0 && offsetS <= 11),
        assert(offsetM >= 0 && offsetM <= 11),
        assert(offsetL >= 0 && offsetL <= 11),
        assert(colS == null || (colS + offsetS <= 12),
            "sum of the col and the respective offset should be less than or equal to 12"),
        assert(colM == null || (colM + offsetM <= 12),
            "sum of the col and the respective offset should be less than or equal to 12"),
        assert(colL == null || (colL + offsetL <= 12),
            "sum of the col and the respective offset should be less than or equal to 12");

  int col = 0;
  int offsetWithCol = 0;

  void _setCurrentScreen(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < _widthMobile) {
      col = colS;
      offsetWithCol = (offsetS + col >= 12) ? 12 : offsetS + col;
    } else if (width < _widthTab) {
      col = colM ?? colS;
      offsetWithCol = (offsetM + col >= 12) ? 12 : offsetM + col;
    } else {
      col = colL ?? colM ?? colS;
      offsetWithCol = (offsetL + col >= 12) ? 12 : offsetL + col;
    }
  }

  @override
  Widget build(BuildContext context) {
    _setCurrentScreen(context);
    return _createDivWidget(child);
  }

  Widget _createDivWidget(Widget child) {
    return LayoutBuilder(builder: (ctx, box) {
      double width = (box.maxWidth / 12) * offsetWithCol;
      return width == 0
          ? SizedBox.shrink()
          : SizedBox(
              width: width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: (box.maxWidth / 12) * col, child: child),
                ],
              ),
            );
    });
  }
}
