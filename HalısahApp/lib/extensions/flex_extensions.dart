import 'package:flutter/material.dart';

extension FlexExtension on Flex {
  separated(Widget separator) {
    final iterator = this.children.iterator;

    if (!iterator.moveNext()) return this;

    final children = <Widget>[];
    children.add(iterator.current);

    while (iterator.moveNext()) {
      children.add(separator);
      children.add(iterator.current);
    }

    if (direction == Axis.horizontal) {
      return Row(
        key: key,
        children: children,
        crossAxisAlignment: crossAxisAlignment,
        textBaseline: textBaseline,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
      );
    } else {
      return Column(
        key: key,
        children: children,
        crossAxisAlignment: crossAxisAlignment,
        textBaseline: textBaseline,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
      );
    }
  }
}
