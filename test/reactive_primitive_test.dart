import 'package:flutter_deep_state_manage/extensions/state_observable_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing reactive primitive', () {
    test('Should test the reactive [int]', () {
      //arrange
      bool isCallbackExecuted = false;
      final observableInt = 0.obs();

      //act
      observableInt.addListener(() {
        isCallbackExecuted = true;
      });
      observableInt.state++;

      //assert
      expect(observableInt.state, 1);
      expect(isCallbackExecuted, true);
    });

    test('Should test the reactive [double]', () {
      //arrange
      bool isCallbackExecuted = false;
      final observableDouble = 0.0.obs();

      //act
      observableDouble.addListener(() {
        isCallbackExecuted = true;
      });
        observableDouble.state += 1.25;

      //assert
      expect(observableDouble.state, 1.25);
      expect(isCallbackExecuted, true);
    });

    test('Should test the reactive [String]', () {
      //arrange
      bool isCallbackExecuted = false;
      final observableString = 'Hello'.obs();

      //act
      observableString.addListener((){
        isCallbackExecuted = true;
      });
      observableString.state += ' World!';

      //assert
      expect(observableString.state, 'Hello World!');
      expect(isCallbackExecuted, true);
    });

    test('Should test reactive [bool]', () {
      //arrange
      bool isCallbackExecuted = false;
      final observableBool = false.obs();

      //act
      observableBool.addListener(() {
        isCallbackExecuted = true;
      });
      observableBool.state = true;

      //assert
      expect(observableBool.state, true);
      expect(isCallbackExecuted, true);
    });
  });
}
