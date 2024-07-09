import 'dart:async';

import 'package:antauri/app/computer/domain/repository/computer_repository.dart';
import 'package:antauri/core/machine/completable_use_case.dart';

class LoadAppsUseCase extends CompletableUseCase<void, void> {
  final ComputerRepository _repository;

  LoadAppsUseCase(this._repository);

  @override
  Future<Stream<void>> buildStream(void params) async {
    StreamController<void> controller = StreamController();
    try {
      controller.add(await _repository.loadApps());
    } catch (e) {
      controller.addError(e);
    }
    controller.close();
    return controller.stream;
  }
}
