import 'package:antauri/app/computer/domain/entities/desktop_app_entity.dart';
import 'package:antauri/app/computer/presentation/widgets/desktop_icon.dart';
import 'package:antauri/config/themes/app_text_theme.dart';
import 'package:antauri/utils/extras.dart';
import 'package:flutter/material.dart';

class AppCardWidget extends StatefulWidget {
  const AppCardWidget({
    super.key,
    required this.entity,
    required this.onPressed,
  });

  final DesktopAppEntity entity;
  final VoidCallback onPressed;

  @override
  State<AppCardWidget> createState() => _AppCardWidgetState();
}

class _AppCardWidgetState extends State<AppCardWidget> {
  bool _hover = false;
  bool _press = false;

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 3;
    if (isMediumSizedWindow()) {
      crossAxisCount = 4;
    }
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) {
        if (mounted) {
          setState(() {
            _press = true;
          });
        }
      },
      onTapUp: (details) {
        if (mounted) {
          setState(() {
            _press = false;
          });
        }
      },
      onTapCancel: () {
        if (mounted) {
          setState(() {
            _press = false;
          });
        }
      },
      child: MouseRegion(
        onEnter: (event) => setState(() => _hover = true),
        onExit: (event) => setState(() => _hover = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 250),
          scale: _press ? 0.9 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: MediaQuery.sizeOf(context).width / crossAxisCount -
                (crossAxisCount * 10),
            height: 96,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hover ? const Color(0xFFD0D0F8) : Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: _hover
                      ? Colors.blue.withOpacity(0.2)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: _hover ? 10 : 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 96,
                    child: DesktopIcon(
                      path: widget.entity.icon,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.entity.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              ConfigurableTextStyle.withFontSize(16).makeMedium(),
                        ),
                        Text(
                          widget.entity.comment,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: ConfigurableTextStyle.withFontSize(14),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
