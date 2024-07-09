import 'package:antauri/app/computer/presentation/widgets/header/header_button_skin.dart';
import 'package:antauri/config/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderBackButton extends StatelessWidget {
  const HeaderBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return HeaderButtonSkin(
      onPressed: onPressed,
      child: Text(
        "Back",
        style: ConfigurableTextStyle.withFontSize(16).makeBold(),
      ),
    );
  }
}
