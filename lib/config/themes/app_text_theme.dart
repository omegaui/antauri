import 'package:flutter/material.dart';

class _AppTextTheme {
  _AppTextTheme._();

  static const Color foreground = Colors.black;
}

extension ConfigurableTextStyle on TextStyle {

  static Text generate(String text, double size) {
    return Text(
      text,
      style: withFontSize(size),
    );
  }

  static TextStyle withFontSize(double size) {
    return TextStyle(
      fontFamily: "Sen",
      fontSize: size,
      color: _AppTextTheme.foreground,
    );
  }

  TextStyle withColor(Color color) {
    return copyWith(
      color: color,
    );
  }

  TextStyle makeBold() {
    return copyWith(
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle makeSlightBold() {
    return copyWith(
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle makeItalic() {
    return copyWith(
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle makeExtraBold() {
    return copyWith(
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle makeMedium() {
    return copyWith(
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle fontSize(double size) {
    return copyWith(
      fontSize: size,
    );
  }
}
