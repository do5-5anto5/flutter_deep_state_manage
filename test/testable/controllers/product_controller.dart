import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/controllers/state_observable.dart';

import '../entities/product_entity.dart';
import '../states/base_state.dart';

@visibleForTesting
class ProductController extends StateObservable<BaseState> {
  ProductController() : super(InitialState());

  @visibleForTesting
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
