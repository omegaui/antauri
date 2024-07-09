import 'package:antauri/config/themes/app_text_theme.dart';
import 'package:antauri/config/themes/window/header/header_button_skin_decorations.dart';
import 'package:flutter/material.dart';

class HeaderButtonSkin extends StatefulWidget {
  const HeaderButtonSkin({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  State<HeaderButtonSkin> createState() => _HeaderButtonSkinState();
}

class _HeaderButtonSkinState extends State<HeaderButtonSkin> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() => _hover = true),
        onExit: (event) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _hover
                ? HeaderButtonSkinDecorations.hoverColor
                : HeaderButtonSkinDecorations.backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
