import 'package:antauri/config/themes/window/header/app_window_control_decorations.dart';
import 'package:flutter/material.dart';

class AppWindowControl extends StatefulWidget {
  const AppWindowControl({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final String icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  State<AppWindowControl> createState() => _AppWindowControlState();
}

class _AppWindowControlState extends State<AppWindowControl> with AppWindowControlDecorations{
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() => _hover = true),
        onExit: (event) => setState(() => _hover = false),
        child: Tooltip(
          message: widget.tooltip,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: _hover
                  ? AppWindowControlDecorations.hoverColor
                  : AppWindowControlDecorations.backgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: SizedBox.square(
                dimension: 25,
                child: Image.asset(
                  widget.icon,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                  isAntiAlias: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
