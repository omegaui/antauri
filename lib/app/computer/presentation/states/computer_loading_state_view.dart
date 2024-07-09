import 'package:antauri/config/themes/app_text_theme.dart';
import 'package:antauri/config/themes/window/frame_decorations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComputerLoadingStateView extends StatelessWidget with FrameDecorations {
  const ComputerLoadingStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FrameDecorations.backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConfigurableTextStyle.generate("Reading desktop entries", 16),
            const Gap(8),
            const SizedBox(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
