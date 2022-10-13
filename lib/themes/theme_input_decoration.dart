import 'package:flutter/material.dart';

class ThemeInputDecoration extends InputDecoration {
  const ThemeInputDecoration.borderNone()
      : super(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        );
}
