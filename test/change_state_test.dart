import 'package:flutter_test/flutter_test.dart';

import 'testable/controllers/counter_change_state.dart';

void main() {
  group('Should Test ChangeState', () {
    test('Should increment counter', () {
      //Arrange
      final CounterChangeState changeState = CounterChangeState();
      //Act
      changeState.increment();
      //Assert
      expect(changeState.counter, 1);
    });
    test('Should execute callback', () {
      //Arrange
      bool isCallbackExecuted = false;
      final CounterChangeState changeState = CounterChangeState();

      void callback() {
        isCallbackExecuted = true;
      }

      //Act
      changeState.addListener(callback);
      changeState.increment();
      
      //Assert
      expect(changeState.counter, 1);
      expect(isCallbackExecuted, true);
    });
  });
}
