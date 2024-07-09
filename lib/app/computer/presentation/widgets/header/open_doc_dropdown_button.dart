import 'package:antauri/app/computer/presentation/widgets/header/header_button_skin.dart';
import 'package:antauri/config/themes/app_text_theme.dart';
import 'package:flutter/material.dart';

class OpenDocDropdownButton extends StatelessWidget {
  const OpenDocDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return HeaderButtonSkin(
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Open",
            style: ConfigurableTextStyle.withFontSize(16).makeBold(),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black,
            size: 28,
          ),
        ],
      ),
    );
  }
}
