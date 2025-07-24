import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/extensions/state_observable_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import 'testable/controllers/product_controller.dart';
import 'testable/entities/product_entity.dart';
import 'testable/states/base_state.dart';

void main() {
  group('Should test State Pattern', () {
    test('Should generate SuccessState when call (getProducts)', () {
      //Arrange
      final productController = ProductController();
      expect(productController.state, isA<InitialState>());

      //Act
      productController.getProducts();

      //Assert
      expect(productController.state, isA<SuccessState<List<Product>>>());
    });

    test('Should generate states in sequence when get success', () {
      //Arrange
      final productController = ProductController();
      expect(
        productController.asStream(),
        emitsInOrder([
          isInstanceOf<InitialState>(),
          isInstanceOf<LoadingState>(),
          isInstanceOf<SuccessState>(),
        ]),
      );

      productController.getProducts();
    });

    test('Should generate states in sequence when get error', () {
      final productController = ProductController();
      expect(
        productController.asStream(),
        emitsInOrder([
          isInstanceOf<InitialState>(),
          isInstanceOf<LoadingState>(),
          isInstanceOf<ErrorState>(),
        ]),
      );

      productController.generateError();
    });

    test(
      'Should generate states in sequence when get an error after a success',
      () {
        final productController = ProductController();
        expect(
          productController.asStream(),
          emitsInOrder([
            isInstanceOf<InitialState>(),
            isInstanceOf<LoadingState>(),
            isInstanceOf<SuccessState>(),
            isInstanceOf<LoadingState>(),
            isInstanceOf<ErrorState>(),
          ]),
        );

        productController.getProducts();
        productController.generateError();
      },
    );

    test('Testing ValueNotifier', () {
      final valueNotifier = ValueNotifier(0);

      expect(valueNotifier.asStream(), emitsInOrder([0, 1, 2]));

      valueNotifier.value++;
      valueNotifier.value++;
    });
  });
}
