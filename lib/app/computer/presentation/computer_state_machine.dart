import 'package:antauri/app/computer/domain/entities/desktop_app_entity.dart';
import 'package:antauri/core/machine/state_machine.dart';

class ComputerStateMachine extends StateMachine<ComputerEvent, ComputerState> {
  ComputerStateMachine() : super(ComputerLoadingState());

  @override
  void changeStateOnEvent(ComputerEvent e) {
    switch (e.runtimeType) {
      case const (ComputerLoadingEvent):
        currentState = ComputerLoadingState();
        break;
      case const (ComputerLoadedEvent):
        currentState = ComputerLoadedState();
        break;
      case const (ComputerViewAppEvent):
        currentState = ComputerViewAppState(
          entity: (e as ComputerViewAppEvent).entity,
        );
    }
  }
}

class ComputerState {}

class ComputerLoadingState extends ComputerState {}

class ComputerLoadedState extends ComputerState {}

class ComputerViewAppState extends ComputerState {
  final DesktopAppEntity entity;

  ComputerViewAppState({required this.entity});
}

class ComputerEvent {}

class ComputerLoadingEvent extends ComputerEvent {}

class ComputerLoadedEvent extends ComputerEvent {}

class ComputerViewAppEvent extends ComputerEvent {
  final DesktopAppEntity entity;

  ComputerViewAppEvent({required this.entity});
}
