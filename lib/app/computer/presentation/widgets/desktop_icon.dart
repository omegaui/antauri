import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DesktopIcon extends StatelessWidget {
  const DesktopIcon({
    super.key,
    required this.path,
    this.width,
    this.height,
  });

  final String path;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final icon = path;
    if (icon.endsWith('.xpm') || icon.endsWith('.svgz')) {
      return Icon(
        Icons.ac_unit,
        size: width,
      );
    } else if (icon.endsWith('.svg')) {
      return SvgPicture.asset(
        icon,
        width: width,
        height: height,
      );
    }
    return Image.asset(
      icon,
      width: width,
      height: height,
      filterQuality: FilterQuality.high,
    );
  }
}
