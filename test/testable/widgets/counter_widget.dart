import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/builders/observable_buider.dart';

import '../controllers/observable_counter.dart';

@visibleForTesting
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

const incrementButtonKey = 'increment_key';

class _CounterWidgetState extends State<CounterWidget> {
  final ObservableCounter _counter = ObservableCounter();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ObservableBuider(
          observable: _counter,
          builder: (context, child) {
            return Text('Valor do counter : ${_counter.counter}');
          }
        ),
        ElevatedButton(
          key: const Key(incrementButtonKey),
          onPressed: () {
            _counter.increment();
          },
          child: const Text('Incrementar'),
        ),
      ],
    );
  }
}