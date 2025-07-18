import 'package:flutter_deep_state_manage/contracts/observable_state.dart';

import 'change_state.dart';

class StateObservable<T> extends ChangeState implements ObservableState {
  T _state;

  StateObservable(this._state);

  @override
  T get state => _state;

  set state(T newState) {
    if (_state == newState) return;
    _state = newState;
    notifyCallback();
  }
}