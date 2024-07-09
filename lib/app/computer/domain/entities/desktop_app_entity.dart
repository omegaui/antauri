import 'package:antauri/app/computer/domain/entities/desktop_entry_type.dart';
import 'package:sealed_languages/sealed_languages.dart';

class DesktopAppEntity {
  final NaturalLanguage? language;
  final String id;
  final String name;
  final String genericName;
  final String _comment;
  final String exec;
  final String icon;
  final bool startupNotify;
  final bool terminal;
  final DesktopEntryType type;
  final List<String> categories;
  final List<String> keywords;
  final List<DesktopAppEntity> variants;

  String get comment => _comment.isEmpty ? "No Description Provided" : _comment;

  DesktopAppEntity({
    required this.language,
    required this.id,
    required this.name,
    required this.genericName,
    required String comment,
    required this.exec,
    required this.icon,
    required this.startupNotify,
    required this.terminal,
    required this.type,
    required this.categories,
    required this.keywords,
    required this.variants,
  }) : _comment = comment;

  // create a clone function
  DesktopAppEntity.clone(
    DesktopAppEntity source, {
    NaturalLanguage? language,
    String? id,
    String? name,
    String? genericName,
    String? comment,
    String? exec,
    String? icon,
    bool? startupNotify,
    bool? terminal,
    DesktopEntryType? type,
    List<String>? categories,
    List<String>? keywords,
    List<DesktopAppEntity>? variants,
  })  : language = language ?? source.language,
        id = id ?? source.id,
        name = name ?? source.name,
        genericName = genericName ?? source.genericName,
        _comment = comment ?? source._comment,
        exec = exec ?? source.exec,
        icon = icon ?? source.icon,
        startupNotify = startupNotify ?? source.startupNotify,
        terminal = terminal ?? source.terminal,
        type = type ?? source.type,
        categories = categories ?? source.categories,
        keywords = keywords ?? source.keywords,
        variants = variants ?? source.variants;

  // create a copyWith function
  DesktopAppEntity copyWith({
    NaturalLanguage? language,
    String? id,
    String? name,
    String? genericName,
    String? comment,
    String? exec,
    String? icon,
    bool? startupNotify,
    bool? terminal,
    DesktopEntryType? type,
    List<String>? categories,
    List<String>? keywords,
    List<DesktopAppEntity>? variants,
  }) {
    return DesktopAppEntity(
      language: language ?? this.language,
      id: id ?? this.id,
      name: name ?? this.name,
      genericName: genericName ?? this.genericName,
      comment: comment ?? _comment,
      exec: exec ?? this.exec,
      icon: icon ?? this.icon,
      startupNotify: startupNotify ?? this.startupNotify,
      terminal: terminal ?? this.terminal,
      type: type ?? this.type,
      categories: categories ?? this.categories,
      keywords: keywords ?? this.keywords,
      variants: variants ?? this.variants,
    );
  }

  bool isApplication() {
    if(type == DesktopEntryType.application && !terminal && icon.isNotEmpty) {
      return icon.contains('/');
    }
    return false;
  }
}
