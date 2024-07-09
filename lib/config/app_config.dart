class AppConfig {
  static bool _debugMode = false;
  static bool get debugMode => _debugMode;

  static String get version => "v1";

  AppConfig.initializeWithArguments(List<String> arguments) {
    _debugMode = arguments.contains('--debug');
  }
}
