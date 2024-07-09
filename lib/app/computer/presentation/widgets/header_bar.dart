import 'package:antauri/app/computer/presentation/widgets/header/app_window_control.dart';
import 'package:antauri/app/computer/presentation/widgets/header/header_back_button.dart';
import 'package:antauri/app/computer/presentation/widgets/header/open_doc_dropdown_button.dart';
import 'package:antauri/app/computer/presentation/widgets/header/tabsystem/app_tabs.dart';
import 'package:antauri/config/themes/app_text_theme.dart';
import 'package:antauri/config/themes/window/header_decorations.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class HeaderBar extends StatelessWidget with HeaderDecorations {
  const HeaderBar({
    super.key,
    required this.title,
    this.subTitle,
    this.showTabs = true,
    this.onBackButtonPressed,
  });

  final String title;
  final String? subTitle;
  final bool showTabs;
  final VoidCallback? onBackButtonPressed;

  static PreferredSize create({
    required String title,
    String? subTitle,
    bool showTabs = true,
    VoidCallback? onBackButtonPressed,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: MoveWindow(
        child: HeaderBar(
          title: title,
          subTitle: subTitle,
          showTabs: showTabs,
          onBackButtonPressed: onBackButtonPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: HeaderDecorations.backgroundColor,
        border: Border(
          bottom: BorderSide(color: HeaderDecorations.borderColor, width: 2),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onBackButtonPressed != null) HeaderBackButton(onPressed: onBackButtonPressed!),
                if (onBackButtonPressed == null) const OpenDocDropdownButton(),
                const Gap(10),
                if (showTabs) const AppTabs(),
              ],
            ),
          ),
          Align(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: ConfigurableTextStyle.withFontSize(16).makeBold(),
                ),
                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: ConfigurableTextStyle.withFontSize(12).makeMedium(),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              spacing: 13,
              children: [
                AppWindowControl(
                  icon: 'assets/icons/controls/minimize.png',
                  tooltip: "Minimize",
                  onPressed: () {
                    appWindow.minimize();
                  },
                ),
                AppWindowControl(
                  icon: 'assets/icons/controls/maximize.png',
                  tooltip: "MaximizeOrRestore",
                  onPressed: () {
                    appWindow.maximizeOrRestore();
                  },
                ),
                AppWindowControl(
                  icon: 'assets/icons/controls/close.png',
                  tooltip: "Close",
                  onPressed: () {
                    appWindow.close();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
