import 'package:antauri/app/computer/presentation/widgets/header/tabsystem/app_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum _AppTab {
  editor,
  computer,
  library,
}

class AppTabs extends StatefulWidget {
  const AppTabs({super.key});

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> {
  _AppTab _appTab = _AppTab.computer;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        AppTab(
          tabIcon: 'assets/icons/tabs/new-file',
          tooltip: "Create New Desktop Entry",
          active: _appTab == _AppTab.editor,
          onPressed: () {
            setState(() {
              _appTab = _AppTab.editor;
            });
          },
        ).animate().slideY(
          begin: -2,
          end: 0,
          delay: const Duration(milliseconds: 500),
        ),
        AppTab(
          tabIcon: 'assets/icons/tabs/computer',
          tooltip: "Your Computer's Desktop Entries",
          active: _appTab == _AppTab.computer,
          onPressed: () {
            setState(() {
              _appTab = _AppTab.computer;
            });
          },
        ).animate().slideY(
          begin: -2,
          end: 0,
          delay: const Duration(milliseconds: 750),
        ),
        AppTab(
          tabIcon: 'assets/icons/tabs/library',
          tooltip: "Pick from Library",
          active: _appTab == _AppTab.library,
          onPressed: () {
            setState(() {
              _appTab = _AppTab.library;
            });
          },

        ).animate().slideY(
          begin: -2,
          end: 0,
          delay: const Duration(milliseconds: 1000),
        ),
      ],
    );
  }
}
