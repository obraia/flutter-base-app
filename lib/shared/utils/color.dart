import 'package:flutter/material.dart';

class ColorUtil {
  static Color fromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    } else {
      return Colors.black;
    }
  }

  static color(String s) {}
}
