import 'package:antauri/config/themes/window/header/app_tab_decorations.dart';
import 'package:flutter/material.dart';

class AppTab extends StatefulWidget {
  const AppTab({
    super.key,
    required this.tabIcon,
    required this.tooltip,
    required this.active,
    required this.onPressed,
  });

  final String tabIcon;
  final String tooltip;
  final bool active;
  final VoidCallback onPressed;

  @override
  State<AppTab> createState() => _AppTabState();
}

class _AppTabState extends State<AppTab> with AppTabDecorations {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final iconPath = '${widget.tabIcon}.png';
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
            decoration: BoxDecoration(
              color: _getBodyColor(),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(4),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Image.asset(
                  iconPath,
                  key: ValueKey(iconPath),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBodyColor() {
    if (widget.active) {
      return AppTabDecorations.selectedColor;
    } else if (_hover) {
      return AppTabDecorations.hoverColor;
    }
    return AppTabDecorations.backgroundColor;
  }
}
