import 'package:antauri/config/app_config.dart';
import 'package:antauri/config/themes/app_text_theme.dart';
import 'package:antauri/config/themes/window/frame_decorations.dart';
import 'package:antauri/core/injector/injector.dart';
import 'package:antauri/core/routing/route_service.dart';
import 'package:antauri/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:get/get.dart';

void main(List<String> arguments) async {
  AppConfig.initializeWithArguments(arguments);
  runApp(const App());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1100, 740);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Antauri";
    win.show();
  });
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    Injector.injectDependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: AppConfig.debugMode,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        dividerColor: const Color(0xFFF5F5F5),
        popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
        chipTheme: ChipThemeData(
          side: BorderSide(color: Colors.grey.shade300)
        ),
        tooltipTheme: TooltipThemeData(
          waitDuration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          textStyle:
              ConfigurableTextStyle.withFontSize(12).withColor(Colors.white),
          decoration: BoxDecoration(
            color: const Color(0xFF2e2e2e),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
      getPages: RouteService.pages,
      initialRoute: Routes.home,
      builder: (context, child) {
        return Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: FrameDecorations.decoration,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
