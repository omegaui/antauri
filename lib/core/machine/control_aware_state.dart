import 'package:antauri/core/machine/state_controller.dart';
import 'package:flutter/material.dart';

abstract class ControlAwareState<View extends StatefulWidget>
    extends State<View> {
  final StateController controller;

  ControlAwareState(this.controller) {
    controller.refreshUICallback = () {
      if (mounted) {
        setState(() {});
      }
    };
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
