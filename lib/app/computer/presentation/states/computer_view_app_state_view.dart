import 'package:antauri/app/computer/presentation/computer_state_controller.dart';
import 'package:antauri/app/computer/presentation/computer_state_machine.dart';
import 'package:antauri/app/computer/presentation/widgets/desktop_icon.dart';
import 'package:antauri/config/themes/widgets/text_button_decorations.dart';
import 'package:antauri/app/computer/presentation/widgets/header_bar.dart';
import 'package:antauri/config/themes/window/frame_decorations.dart';
import 'package:antauri/config/themes/app_text_theme.dart';
import 'package:antauri/utils/extras.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComputerViewAppStateView extends StatelessWidget with FrameDecorations {
  const ComputerViewAppStateView({
    super.key,
    required this.controller,
    required this.state,
  });

  final ComputerStateController controller;
  final ComputerViewAppState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FrameDecorations.backgroundColor,
      appBar: HeaderBar.create(
        title: "Viewing Desktop Entry",
        subTitle: state.entity.name,
        showTabs: false,
        onBackButtonPressed: () {
          controller.gotoInitialState();
        },
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DesktopIcon(
              path: state.entity.icon,
              width: 256,
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                state.entity.comment,
                style: ConfigurableTextStyle.withFontSize(14)
                    .makeMedium()
                    .makeItalic(),
              ),
            ),
            const Gap(10),
            if (state.entity.variants.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Text(
                  "This desktop entry supports ${state.entity.variants.where((e) => e.language != null).map((e) => e.language!.internationalName).join(", ")} locales.",
                  textAlign: TextAlign.center,
                  style: ConfigurableTextStyle.withFontSize(14).makeMedium(),
                ),
              ),
              const Gap(10),
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () async {
                    await launch(state.entity.exec);
                  },
                  style: TextButtonDecorations.style(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.grey,
                  ),
                  child: Text(
                    "Open App",
                    style: ConfigurableTextStyle.withFontSize(14)
                        .makeMedium()
                        .withColor(Colors.grey.shade800),
                  ),
                ),
                const Gap(10),
                TextButton(
                  onPressed: () {},
                  style: TextButtonDecorations.style(),
                  child: Text(
                    "Lock App",
                    style: ConfigurableTextStyle.withFontSize(14)
                        .makeMedium()
                        .withColor(Colors.blueAccent),
                  ),
                ),
                const Gap(10),
                TextButton(
                  onPressed: () {},
                  style: TextButtonDecorations.style(
                    backgroundColor: Colors.red.shade100.withOpacity(0.5),
                    foregroundColor: Colors.red,
                  ),
                  child: Text(
                    "Hide App",
                    style: ConfigurableTextStyle.withFontSize(14)
                        .makeMedium()
                        .withColor(Colors.redAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
