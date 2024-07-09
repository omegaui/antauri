import 'package:antauri/app/computer/data/computer_repo_impl.dart';
import 'package:antauri/app/computer/domain/repository/computer_repository.dart';
import 'package:antauri/app/computer/domain/usecases/load_apps_usecase.dart';
import 'package:antauri/app/computer/presentation/computer_state_presenter.dart';
import 'package:antauri/core/storage/runtime_storage.dart';
import 'package:get/get.dart';

class Injector {
  Injector._();

  static void injectDependencies() {
    Get.put<RuntimeStorage>(RuntimeStorage(), permanent: true);

    Get.lazyPut<ComputerRepository>(() => ComputerRepoImpl());
    Get.put<LoadAppsUseCase>(LoadAppsUseCase(Get.find()));
    Get.put<ComputerStatePresenter>(ComputerStatePresenter(Get.find()));
  }
}
