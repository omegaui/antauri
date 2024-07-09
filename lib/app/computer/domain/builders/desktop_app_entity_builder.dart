import 'dart:io';

import 'package:antauri/app/computer/domain/entities/desktop_app_entity.dart';
import 'package:antauri/app/computer/domain/entities/desktop_entry_type.dart';
import 'package:antauri/core/storage/runtime_storage.dart';
import 'package:get/get.dart';
import 'package:sealed_languages/sealed_languages.dart';

class DesktopAppEntityBuilder {
  final RuntimeStorage _storage = Get.find();
  String? _systemIconTheme;

  Future<void> identifySystemTheme() async {
    _systemIconTheme = await _getSystemIconTheme();
  }

  Future<DesktopAppEntity> fromFile(String path) async {
    final reader = File(path);
    final content = await reader.readAsLines();
    final properties = <String, String>{};
    bool parseDesktopEntry = false;
    bool readingDescription = false;
    for (var line in content) {
      line = line.trim();
      if (line.startsWith('#')) {
        // ignore comments
        continue;
      }
      if(line.startsWith('[Desktop Action')) {
        parseDesktopEntry = false;
        continue;
      }
      if (line == '[Desktop Entry]') {
        parseDesktopEntry = true;
      } else if (parseDesktopEntry) {
        if (line.contains('=')) {
          final index = line.indexOf('=');
          final key = line.substring(0, index).toLowerCase();
          final value = line.substring(index + 1);
          properties[key] = value;
          if (key.isCaseInsensitiveContains('comment')) {
            readingDescription = true;
          } else {
            readingDescription = false;
          }
        } else if (readingDescription) {
          properties['comment'] = '${properties['comment']!}\n$line';
        }
      }
    }

    List<DesktopAppEntity> variants = [];

    if (_isMultiLingualSupported(properties)) {
      final languageCodes = <String>{};
      for (final key in properties.keys) {
        if (_isMultiLingualKey(key)) {
          languageCodes.add(_getLanguageCode(key));
        }
      }
      for (final languageCode in languageCodes) {
        final variantProperties =
            _getLanguageProperties(languageCode, properties);
        variants.add(_buildObject(
            path, languageCode, variantProperties, properties, []));
      }
    }

    return _buildObject(path, 'en', properties, {}, variants);
  }

  Future<String?> _getSystemIconTheme() async {
    final result = await Process.run(
      'gsettings',
      ['get', 'org.gnome.desktop.interface', 'icon-theme'],
    );
    if (result.exitCode == 0) {
      var theme = (result.stdout as String).trim();
      return theme.substring(1, theme.length - 1);
    } else {
      return null;
    }
  }

  String? getAbsoluteIconFromSystemThemes(String iconName) {
    String? lastIdentifiedPath;
    if (iconName.isEmpty) {
      return null;
    }
    for (var path in _storage.icons) {
      if (path.contains('$iconName.')) {
        lastIdentifiedPath = path;
        if (_systemIconTheme != null) {
          if (path.contains('/$_systemIconTheme/')) {
            break;
          }
        } else {
          break;
        }
      }
    }
    return lastIdentifiedPath;
  }

  DesktopAppEntity _buildObject(
      String id,
      String languageCode,
      Map<String, String> properties,
      Map<String, String> fallbackProperties,
      List<DesktopAppEntity> variants) {
    // the most critical part is to find the correct icon of the app
    String icon = properties['icon'] ?? fallbackProperties['icon'] ?? "";
    // checking if [icon] is not a path
    if (!icon.startsWith('/')) {
      icon = getAbsoluteIconFromSystemThemes(icon) ?? icon;
    }
    return DesktopAppEntity(
      language: NaturalLanguage.maybeFromCodeShort(languageCode),
      id: id,
      name: properties['name'] ?? fallbackProperties['name'] ?? "",
      genericName:
          properties['genericname'] ?? fallbackProperties['genericname'] ?? "",
      comment: properties['comment'] ?? fallbackProperties['comment'] ?? "",
      exec: properties['exec'] ?? fallbackProperties['exec'] ?? "",
      icon: icon,
      startupNotify: bool.tryParse(properties['startupNotify'] ?? "false") ??
          bool.tryParse(fallbackProperties['startupNotify'] ?? "false") ??
          false,
      terminal: bool.tryParse(properties['terminal'] ?? "false") ??
          bool.tryParse(fallbackProperties['terminal'] ?? "false") ??
          false,
      type: DesktopEntryType.values.byName(properties['type']?.toLowerCase() ??
          fallbackProperties['type']?.toLowerCase() ??
          "link"),
      categories: List<String>.from(properties['categories']?.split(';') ??
          fallbackProperties['categories']?.split(';') ??
          []),
      keywords: List<String>.from(properties['keywords']?.split(';') ??
          fallbackProperties['keywords']?.split(';') ??
          []),
      variants: variants,
    );
  }

  bool _isMultiLingualSupported(Map<String, String> properties) {
    return properties.keys.any((key) => _isMultiLingualKey(key));
  }

  bool _isMultiLingualKey(String key) {
    return key.contains('[') && key.contains(']');
  }

  String _getRawKeyWithoutLanguageCode(String key) {
    return key.substring(0, key.indexOf('['));
  }

  String _getLanguageCode(String key) {
    return key.substring(key.indexOf('[') + 1, key.indexOf(']'));
  }

  Map<String, String> _getLanguageProperties(
      String languageCode, Map<String, String> properties) {
    final result = <String, String>{};
    final entries = properties.entries;
    for (final entry in entries) {
      if (_isMultiLingualKey(entry.key) &&
          _getLanguageCode(entry.key) == languageCode) {
        result[_getRawKeyWithoutLanguageCode(entry.key)] = entry.value;
      }
    }
    return result;
  }
}
