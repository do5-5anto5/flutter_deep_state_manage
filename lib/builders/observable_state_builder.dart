import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/controllers/state_observable.dart';

class ObservableStateBuilder<T> extends StatefulWidget {
  final StateObservable<T> stateObservable;
  final Widget Function(BuildContext context, T state, Widget? child) builder;
  final Widget? child;
  final void Function(BuildContext context, T newState)? listener;
  const ObservableStateBuilder({
    super.key,
    required this.stateObservable,
    required this.builder,
    this.child,
    this.buildWhen,
    this.listener,
  });
  final bool Function(T oldState, T newState)? buildWhen;

  @override
  State<ObservableStateBuilder<T>> createState() =>
      _ObservableStateBuilderState<T>();
}

class _ObservableStateBuilderState<T> extends State<ObservableStateBuilder<T>> {
  late T state;

  @override
  void initState() {
    state = widget.stateObservable.state;
    widget.stateObservable.addListener(callback);
    super.initState();
  }

  void callback() {
    print(shouldRebuild());
    if (shouldRebuild()) {
      state = widget.stateObservable.state;
      if (widget.listener != null) {
        widget.listener!(context, state);
      }
      setState(() {});
    } else {
      state = widget.stateObservable.state;
    }
  }

  // Esse método é usado para determinar se o widget deve ser reconstruído
  // com base na mudança de estado.
  bool shouldRebuild() {
    if (widget.buildWhen != null) {
      return widget.buildWhen!(state, widget.stateObservable.state);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state, widget.child);
  }

  @override
  void dispose() {
    widget.stateObservable.removeListener(callback);
    super.dispose();
  }
}
