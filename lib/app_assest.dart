import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const sunflowerYellow = const Color(0xfffad200);
  static const white = const Color(0x0ffffffff);
  static const warmGrey = const Color(0xFF777777);
  static const black = const Color(0xFF000000);
  static const whiteFive = Color(0xFFDDDDDD);
  static const redAccent = Color(0xFFFF5252);
}

class HexColor {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
