
import 'package:antauri/app/computer/domain/entities/desktop_app_entity.dart';

class RuntimeStorage {
  final List<DesktopAppEntity> _systemApps = [];
  final List<DesktopAppEntity> _userApps = [];
  final List<String> _icons = [];

  List<DesktopAppEntity> get systemApps => _systemApps;
  List<DesktopAppEntity> get userApps => _userApps;
  List<DesktopAppEntity> get allApps => [..._userApps, ...systemApps];
  List<String> get icons => _icons;

  void init() {
    _systemApps.clear();
    _userApps.clear();
    _icons.clear();
  }
  
  void addSystemApp(DesktopAppEntity app) {
    _systemApps.add(app);
  }
  
  void removeSystemApp(DesktopAppEntity app) {
    _systemApps.add(app);
  }

  void updateSystemApp(DesktopAppEntity app) {
    _systemApps.removeWhere((element) => element.id == app.id);
    _systemApps.add(app);
  }

  void addUserApp(DesktopAppEntity app) {
    _userApps.add(app);
  }

  void removeUserApp(DesktopAppEntity app) {
    _userApps.add(app);
  }

  void updateUserApp(DesktopAppEntity app) {
    _userApps.removeWhere((element) => element.id == app.id);
    _userApps.add(app);
  }

  void addIcon(String icon) {
    _icons.add(icon);
  }
}
