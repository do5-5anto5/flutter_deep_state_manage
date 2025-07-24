import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/controllers/state_observable.dart';
import 'package:flutter_test/flutter_test.dart';

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

    test('Should generate states in sequence when get an error after a success', () {
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
    });

    test('Testing ValueNotifier', () {
      final valueNotifier = ValueNotifier(0);

      expect(valueNotifier.asStream(), emitsInOrder([0,1,2]));

      valueNotifier.value++;
      valueNotifier.value++;
    });
  });
}

extension ObservableStream<T> on StateObservable<T> {
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

//Extension to convert ValueNotifier to Stream, verify if the test runs like in `ObservableStream`
extension ObservableValueNotifier<T> on ValueNotifier<T> {
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

abstract class BaseState {}

class InitialState extends BaseState {}

class LoadingState extends BaseState {}

class SuccessState<T extends Object> extends BaseState {
  final T data;

  SuccessState({required this.data});
}

class ErrorState extends BaseState {
  final String message;

  ErrorState({required this.message});
}

class Product {
  final String id;
  final String name;

  Product({required this.id, required this.name});
}

class ProductController extends StateObservable<BaseState> {
  ProductController() : super(InitialState());

  void getProducts() {
    state = LoadingState();

    state = SuccessState(
      data: [
        Product(id: '1', name: 'Product 1'),
        Product(id: '2', name: 'Product 2'),
      ],
    );
  }

  void generateError() {
    state = LoadingState();

    try {
      throw Exception();
    } catch (e) {
      state = ErrorState(message: e.toString());
    }
  }
}
