import 'package:antauri/app/computer/domain/usecases/load_apps_usecase.dart';
import 'package:antauri/core/machine/state_presenter.dart';
import 'package:antauri/core/machine/use_case_observer.dart';

class ComputerStatePresenter extends StatePresenter {
  final LoadAppsUseCase _loadAppsUseCase;

  ComputerStatePresenter(this._loadAppsUseCase);

  @override
  void dispose() {
    _loadAppsUseCase.dispose();
  }

  void loadApps(UseCaseObserver observer) {
    _loadAppsUseCase.execute(null, observer);
  }
}
