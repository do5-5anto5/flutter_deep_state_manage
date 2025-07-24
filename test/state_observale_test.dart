import 'package:flutter_deep_state_manage/controllers/state_observable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Should test StateObservable', () {
    test('Should update state correctly when incremented', () {
      //Arrange
      final observableCounter = StateObservable(0);

      //Act
      observableCounter.state++;

      //Assert
      expect(observableCounter.state, 1);
    });
  });

  test('Shoud execute StateObservable\'s callback when state changes', () {
    //Arrange
    final counterState = StateObservable(0);
    bool isCallbackExecuted = false;

    //Act
    void callback() {
      isCallbackExecuted = true;
    }

    counterState.addListener(callback);
    counterState.state++;

    //Assert
    expect(counterState.state, 1);
    expect(isCallbackExecuted, true);
  });
}
