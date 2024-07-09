import 'dart:io';

import 'package:antauri/app/computer/domain/builders/desktop_app_entity_builder.dart';
import 'package:antauri/app/computer/domain/repository/computer_repository.dart';
import 'package:antauri/core/storage/runtime_storage.dart';
import 'package:antauri/utils/desktop_entry_locations.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class ComputerRepoImpl extends ComputerRepository {
  final RuntimeStorage _storage = Get.find();

  /// Loads System Applications installed at these locations into the runtime cache:
  /// - /usr/share/applications
  /// - /usr/local/share/applications
  /// - /opt/local/share/applications
  /// - ~/.local/share/applications
  /// - /var/lib/snapd/desktop/applications
  /// - /var/lib/flatpak/exports/share/applications
  /// - ~/.local/share/flatpak
  @override
  Future<void> loadApps() async {
    // to start with loading system applications
    // we should first have the icons available throughout the system
    _storage.init();
    await loadIcons();
    debugPrint("We have access to ${_storage.icons.length} icons.");
    DesktopAppEntityBuilder builder = DesktopAppEntityBuilder();
    await builder.identifySystemTheme();
    for (final location in DesktopEntryLocations.locations) {
      if (await location.directory.exists()) {
        final files = await location.directory.list().toList();
        for (final file in files) {
          if (basename(file.path).endsWith('.desktop')) {
            final app = await builder.fromFile(file.path);
            if (location.isWritable) {
              _storage.addUserApp(app);
            } else {
              _storage.addSystemApp(app);
            }
          }
        }
      }
    }
    debugPrint(
        "We have access to ${Get.find<RuntimeStorage>().allApps.length} apps.");
  }

  Future<void> loadIcons() async {
    await loadFromPixMaps(
      '/usr/share/pixmaps',
      onNotExistEvent: () {
        debugPrint("Couldn't find any icons in /usr/share/pixmaps");
      },
    );
    await loadFromPixMaps(
      '${Platform.environment['HOME']}/.local/share/pixmaps',
      onNotExistEvent: () {
        debugPrint("Couldn't find any icons in ${Platform.environment['HOME']}/.local/share/icons");
      },
    );
    await loadFromThemes(
      '/usr/share/icons',
      onNotExistEvent: () {
        debugPrint("Couldn't find any icons in /usr/share/icons");
      },
    );
    await loadFromThemes(
      '/usr/local/share/icons',
      onNotExistEvent: () {
        debugPrint("Couldn't find any icons in /usr/local/share/icons");
      },
    );
    await loadFromThemes(
      '/var/lib/flatpak/exports/share/icons',
      onNotExistEvent: () {
        debugPrint(
            "Couldn't find any icons in /var/lib/flatpak/exports/share/icons");
      },
    );
    await loadFromThemes(
      '${Platform.environment['HOME']}/.local/share/icons',
      onNotExistEvent: () {
        debugPrint(
            "Couldn't find any icons in ${Platform.environment['HOME']}/.local/share/icons");
      },
    );
  }

  Future<void> loadFromPixMaps(
    String path, {
    required VoidCallback onNotExistEvent,
  }) async {
    Directory pixmapsDir = Directory(path);
    if (!(await pixmapsDir.exists())) {
      onNotExistEvent();
      return;
    }
    var icons = await pixmapsDir.list().toList();
    for (var icon in icons) {
      final stat = await icon.stat();
      if (stat.type == FileSystemEntityType.file) {
        _storage.addIcon(icon.path);
      }
    }
  }

  Future<void> loadFromThemes(
    String path, {
    required VoidCallback onNotExistEvent,
  }) async {
    Directory iconThemesDir = Directory(path);
    if (!(await iconThemesDir.exists())) {
      onNotExistEvent();
      return;
    }
    var themes = await iconThemesDir.list().toList();
    for (var theme in themes) {
      final stat = await theme.stat();
      if (stat.type == FileSystemEntityType.directory) {
        await _loadIconsFromIconThemes(theme.path);
      }
    }
  }

  Future<void> _loadIconsFromIconThemes(String themesDirPath) async {
    await _loadIconsOfSize(themesDirPath, "48x48");
    await _loadIconsOfSize(themesDirPath, "64x64");
    await _loadIconsOfSize(themesDirPath, "72x72");
    await _loadIconsOfSize(themesDirPath, "96x96");
    await _loadIconsOfSize(themesDirPath, "128x128");
    await _loadIconsOfSize(themesDirPath, "192x192");
    await _loadIconsOfSize(themesDirPath, "256x256");
    await _loadIconsOfSize(themesDirPath, "512x512");
    await _loadIconsOfSize(themesDirPath, "scalable");
  }

  Future<void> _loadIconsOfSize(String themesDirPath, String size) async {
    var appDir = Directory("$themesDirPath/$size/apps");
    if (await appDir.exists()) {
      var icons = await appDir.list().toList();
      for (var icon in icons) {
        _storage.addIcon(icon.path);
      }
    }
  }
}
