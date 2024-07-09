import 'package:flutter/material.dart';

class TextButtonDecorations {
  static ButtonStyle style({Color? backgroundColor, Color? foregroundColor}) {
    return TextButton.styleFrom(
      backgroundColor: backgroundColor ?? Colors.blue.shade100.withOpacity(0.5),
      foregroundColor: foregroundColor ?? Colors.blue,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
