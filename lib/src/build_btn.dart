import 'dart:async';

import 'package:flutter/material.dart';
import 'package:input_quantity/src/constant.dart';
import '../input_quantity.dart';

/// default
const cRad = Radius.circular(4);

class BuildBtn extends StatelessWidget {
  /// icon widget
  final Widget? child;

  /// callback on tap
  final Function()? onTap;

  /// button plus or minus
  final bool isPlus;

  /// default button color
  final Color btnColor;

  /// shape border
  final BorderShapeBtn borderShape;

  /// start increasing value
  final void Function(Function? ontap) onStart;

  /// stop increasing value
  final VoidCallback onEndTime;

  /// orientation button
  final ButtonOrientation? orientation;

  /// widget style
  final QtyStyle qtyStyle;

  /// timer for longpress
  final Timer? time;
  const BuildBtn({
    super.key,
    this.borderShape = BorderShapeBtn.none,
    required this.isPlus,
    this.onTap,
    this.btnColor = Colors.teal,
    this.child,
    this.qtyStyle = QtyStyle.classic,
    this.orientation,
    this.time,
    required this.onEndTime,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    bool isCircleBorder = borderShape == BorderShapeBtn.circle;
    bool isSqborder = borderShape == BorderShapeBtn.square;

    return GestureDetector(
      onLongPressStart: (details) => onTap?.call(),
      onLongPressEnd: (details) => onEndTime.call(),
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: isCircleBorder ? BoxShape.circle : BoxShape.rectangle,
          border: borderShape == BorderShapeBtn.none
              ? null
              : Border.all(
                  color: onTap == null ? Colors.grey : btnColor,
                  width: 1,
                ),
          borderRadius: isCircleBorder
              ? null
              : setupBorderRadiusDefault(
                  orientation: orientation ?? ButtonOrientation.vertical,
                  isPlus: isPlus,
                  style: qtyStyle,
                ),
        ),
        child: child ??
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSqborder ? 8.0 : 2.0,
                vertical: (orientation ?? ButtonOrientation.vertical) ==
                        ButtonOrientation.vertical
                    ? 0
                    : 4,
              ),
              child: Icon(
                isPlus ? Icons.add : Icons.remove,
                size: 22,
                color: onTap == null ? Colors.grey : btnColor,
              ),
            ),
      ),
    );
  }
}

BorderRadius setupBorderRadiusDefault(
    {required ButtonOrientation orientation,
    required bool isPlus,
    QtyStyle? style}) {
  if (orientation == ButtonOrientation.horizontal) {
    return BorderRadius.only(
        topLeft: isPlus ? Radius.zero : cRad,
        bottomLeft: isPlus ? Radius.zero : cRad,
        topRight: isPlus ? cRad : Radius.zero,
        bottomRight: isPlus ? cRad : Radius.zero);
  } else {
    if (style == QtyStyle.btnOnRight) {
      return BorderRadius.only(
        topRight: isPlus ? cRad : Radius.zero,
        bottomRight: isPlus ? Radius.zero : cRad,
      );
    } else {
      return BorderRadius.only(
        topLeft: isPlus ? cRad : Radius.zero,
        bottomLeft: isPlus ? Radius.zero : cRad,
      );
    }
  }
}
