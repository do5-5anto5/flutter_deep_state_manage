import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/controllers/change_state.dart';

@visibleForTesting
class ObservableCounter extends ChangeState {
  int counter = 0;

  @visibleForTesting
  void increment() {
    counter++;
    notifyCallback();
  }
}