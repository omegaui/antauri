import 'package:antauri/app/computer/presentation/computer_view.dart';
import 'package:antauri/core/routing/routes.dart';
import 'package:get/get.dart';

class RouteService {
  static final List<GetPage> _pages = [
    GetPage(
      name: Routes.home,
      page: () => const ComputerView(),
    ),
  ];

  static List<GetPage> get pages => _pages;

  void goto(
    String page, {
    bool dropAll = false,
    dynamic arguments,
    Map<String, String>? parameter,
  }) {
    if (dropAll) {
      Get.offNamed(page, arguments: arguments, parameters: parameter);
    } else {
      Get.toNamed(page, arguments: arguments, parameters: parameter);
    }
  }
}
