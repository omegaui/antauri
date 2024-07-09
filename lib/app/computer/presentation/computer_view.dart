import 'package:antauri/app/computer/presentation/computer_state_controller.dart';
import 'package:antauri/app/computer/presentation/computer_state_machine.dart';
import 'package:antauri/app/computer/presentation/states/computer_loaded_state_view.dart';
import 'package:antauri/app/computer/presentation/states/computer_loading_state_view.dart';
import 'package:antauri/app/computer/presentation/states/computer_view_app_state_view.dart';
import 'package:antauri/core/machine/control_aware_state.dart';
import 'package:antauri/core/machine/state_view.dart';
import 'package:flutter/material.dart';

class ComputerView extends StateView {
  const ComputerView({super.key});

  @override
  State<StatefulWidget> createState() => _ComputerViewState();
}

class _ComputerViewState extends ControlAwareState<ComputerView> {
  _ComputerViewState() : super(ComputerStateController());

  @override
  Widget build(BuildContext context) {
    final controller = this.controller as ComputerStateController;
    final currentState = controller.getCurrentState();
    switch (currentState.runtimeType) {
      case const (ComputerLoadingState):
        controller.init();
        return const ComputerLoadingStateView();
      case const (ComputerLoadedState):
        return ComputerLoadedStateView(controller: controller);
      case const (ComputerViewAppState):
        return ComputerViewAppStateView(
          controller: controller,
          state: controller.stateAs<ComputerViewAppState>(),
        );
    }
    throw Exception("Unknown state: ${currentState.runtimeType}");
  }
}
