import 'package:flutter/widgets.dart';
import 'package:flutter_deep_state_manage/controllers/change_state.dart';
import 'package:flutter_deep_state_manage/controllers/state_observable.dart';

mixin ChangeStateMixin<T extends StatefulWidget> on State<T> {
  final List<ChangeState> _changeStates = [];

  void useChangeState(ChangeState changeState) {
    changeState.addListener(_callback);
    _changeStates.add(changeState);
  }

  void _callback() {
    if (mounted) setState(() {});
  }

  StateObservable<T> useStateObservable<T>(T state) {
    final stateObservable = StateObservable<T>(state);
    stateObservable.addListener(_callback);
    _changeStates.add(stateObservable);
    return stateObservable;
  }

  @override
  void dispose() {
    for (ChangeState changeState in _changeStates) {
      changeState.removeListener(_callback);
    }
    super.dispose();
  }
}
