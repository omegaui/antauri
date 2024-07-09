
import 'package:flutter/material.dart';

mixin FrameDecorations {
  static const Color backgroundColor = Colors.white;
  static BoxDecoration decoration = BoxDecoration(
    color: FrameDecorations.backgroundColor,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 16,
      )
    ],
  );
}
