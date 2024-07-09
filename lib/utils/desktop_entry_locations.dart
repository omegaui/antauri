
import 'dart:io';

class DesktopEntryLocation {
  final Directory directory;
  final bool isWritable;

  DesktopEntryLocation(this.directory, this.isWritable);

  factory DesktopEntryLocation.fromUserHome(String path, bool isWritable) {
    final home = Platform.environment['HOME'];
    return DesktopEntryLocation(Directory('$home/$path'), isWritable);
  }
}

class DesktopEntryLocations {
  DesktopEntryLocations._();

  static List<DesktopEntryLocation> locations = [
    DesktopEntryLocation(Directory('/usr/share/applications'), false),
    DesktopEntryLocation(Directory('/usr/local/share/applications'), false),
    DesktopEntryLocation(Directory('/opt/local/share/applications'), false),
    DesktopEntryLocation(Directory('/var/lib/snapd/desktop/applications'), false),
    DesktopEntryLocation(Directory('/var/lib/flatpak/exports/share/applications'), false),
    DesktopEntryLocation.fromUserHome('.local/share/applications', true),
    DesktopEntryLocation.fromUserHome('.local/share/flatpak', true),
  ];
}
