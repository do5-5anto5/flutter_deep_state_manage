import 'package:flutter_deep_state_manage/controllers/change_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Should Test ChangeState', () {
    test('Should increment counter', () {
      //Arrange
      final _CounterChangeState changeState = _CounterChangeState();
      //Act
      changeState.increment();
      //Assert
      expect(changeState.counter, 1);
    });
    test('Should execute callback', () {
      //Arrange
      bool isCallbackExecuted = false;
      final _CounterChangeState changeState = _CounterChangeState();

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

class _CounterChangeState extends ChangeState {
  int counter = 0;

  void increment() {
    counter++;
    notifyCallback();
  }
}
