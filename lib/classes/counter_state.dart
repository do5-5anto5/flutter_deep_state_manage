import 'package:flutter_deep_state_manage/controllers/change_state.dart';

class CounterState extends ChangeState {
  int counter = 0;

  void increment() {
    counter++;
    notifyCallback();
  }
}
