import 'package:antauri/app/computer/domain/entities/desktop_app_entity.dart';
import 'package:antauri/app/computer/presentation/computer_state_machine.dart';
import 'package:antauri/app/computer/presentation/computer_state_presenter.dart';
import 'package:antauri/core/machine/state_controller.dart';
import 'package:antauri/core/machine/use_case_observer.dart';
import 'package:get/get.dart';

class ComputerStateController extends StateController<ComputerStatePresenter,
    ComputerEvent, ComputerState> {
  ComputerStateController()
      : super(
          stateMachine: ComputerStateMachine(),
          presenter: Get.find<ComputerStatePresenter>(),
        );

  void init() {
    presenter.loadApps(UseCaseObserver<void>(
      name: 'LoadApps',
      onComplete: () {
        onEvent(ComputerLoadedEvent());
      },
      onEmit: (_) {},
    ));
  }

  void viewApp(DesktopAppEntity e) {
    onEvent(ComputerViewAppEvent(entity: e));
  }

  void gotoInitialState() {
    onEvent(ComputerLoadedEvent());
  }
}
