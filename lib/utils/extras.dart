import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void doLater(void Function() task) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    task();
  });
}

bool isMediumSizedWindow() {
  return MediaQuery.sizeOf(Get.context!).width > 1400;
}

bool isNormalSizedWindow() {
  return MediaQuery.sizeOf(Get.context!).width < 1400;
}

class TipAndTricks {
  static final List<String> _tips = [
    "You can lock any of your apps with a password.",
    "You can even hide your apps from coming in the launcher.",
    "You can create AI generated app localizations.",
    "Antauri can automatically find an icon for your desktop entry from the internet.",
    "Antauri is written using the Flutter framework",
    "@omegaui is the creator of Antauri, find him on GitHub.",
    "Antauri got its name from a cartoon series character",
    "Antauri provides some predefined desktop entries in the Library Section.",
  ];

  static String getRandomTip() {
    _tips.shuffle();
    return _tips.first;
  }
}

File _launcherFile = File("command-launcher.sh");

Future<void> prepareCommandLauncher() async {
  String contents = "#!/bin/bash\n\$@\n";
  if (!(await _launcherFile.exists())) {
    await _launcherFile.writeAsString(contents);
    await Process.run('chmod', [
      "+x",
      _launcherFile.path,
    ]);
  }
}

Future<void> launch(String command) async {
  debugPrint("Executing: $command");
  await prepareCommandLauncher();
  await Process.run(_launcherFile.absolute.path, [
    command,
  ]);
}
