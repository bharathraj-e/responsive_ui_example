import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  Responsive({
    @required this.children,
    this.runSpacing = 0.0,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
  }) : assert(children != null, "children shoud not be Null");

  /// List<Div> preffered; `Div()`
  final List<Widget> children;

  /// How the children within a run should be placed in the main axis.
  ///
  /// For example, if [alignment] is [WrapAlignment.center], the children in
  /// each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  final WrapAlignment alignment;

  /// How the runs themselves should be placed in the cross axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// Has no effect when wrapped with a scroll widget
  final WrapAlignment runAlignment;

  /// How the children within a run should be aligned relative to each other in
  /// the cross axis.
  ///
  /// Defaults to [WrapCrossAlignment.start].
  ///
  final WrapCrossAlignment crossAxisAlignment;

  /// How much space to place between the runs themselves in the cross axis.
  ///
  /// Defaults to 0.0.
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment,
      runSpacing: runSpacing,
      children: children,
      runAlignment: runAlignment,
      crossAxisAlignment: crossAxisAlignment,
    );
  }
}
