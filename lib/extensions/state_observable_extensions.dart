import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/controllers/state_observable.dart';

@visibleForTesting
extension ObservableStream<T> on StateObservable<T> {
  @visibleForTesting
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(state); //InitialState

    void callback() {
      streamController.add(state); //LoadingState -> SuccessState
    }

    addListener(callback);

    return streamController.stream;
  }
}

@visibleForTesting
extension ObservableValueNotifier<T> on ValueNotifier<T> {
  @visibleForTesting
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(value);

    void callback() {
      streamController.add(value);
    }

    addListener(callback);

    return streamController.stream;
  }
}

extension ReactiveInt on int {
  /// Create a reactive class from primitive int
  ///
  /// example: 0.obs()
  StateObservable<int> obs() => StateObservable<int>(this);
}

extension ReactiveDouble on double {
  /// Create a reactive class from primitive double
  /// 
  /// example: 0.0.obs()
  StateObservable<double> obs() => StateObservable<double>(this);
}

extension ReactiveString on String {
  /// Create a reactive class from  String
  /// 
  /// example: 'Hello'.obs()
  StateObservable<String> obs() => StateObservable<String>(this);
}

extension ReactiveBool on bool {
  /// Create a reactive class from primitive boolean
  /// 
  /// example: false.obs()
  StateObservable<bool> obs() => StateObservable(this);
}
