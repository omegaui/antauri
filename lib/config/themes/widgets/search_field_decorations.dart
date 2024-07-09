
import 'package:antauri/config/themes/window/frame_decorations.dart';
import 'package:flutter/material.dart';

mixin SearchFieldDecorations {
  static Color backgroundColor = FrameDecorations.backgroundColor;
  static InputBorder searchFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: Colors.grey.shade300,
    ),
    borderRadius: BorderRadius.circular(15),
  );
  static InputDecoration searchFieldInputDecoration = InputDecoration(
    border: searchFieldBorder,
    enabledBorder: searchFieldBorder,
    disabledBorder: searchFieldBorder,
    focusedBorder: searchFieldBorder,
    errorBorder: searchFieldBorder,
  );
}
