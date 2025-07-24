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
  });
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
}