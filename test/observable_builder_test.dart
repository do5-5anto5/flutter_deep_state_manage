import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/builders/observable_buider.dart';
import 'package:flutter_deep_state_manage/controllers/change_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Should test ObservableBuilder', () {
    testWidgets('Should test increment widget', (widgetTests) async {
      await widgetTests.pumpWidget(const MaterialApp(home: _CounterWidget()));
      final findText = find.text('Valor do counter : 0');

      final findButton = find.byKey(const Key(incrementButtonKey));

      expect(findText, findsOneWidget);

      expect(findButton, findsOneWidget);
      
      await widgetTests.tap(findButton);
      await widgetTests.pump();

      final nextCounterText = find.text('Valor do counter : 1');

      expect(nextCounterText, findsOneWidget);

    });
  });
}

class _CounterWidget extends StatefulWidget {
  const _CounterWidget({super.key});

  @override
  State<_CounterWidget> createState() => _CounterWidgetState();
}

const incrementButtonKey = 'increment_key';

class _CounterWidgetState extends State<_CounterWidget> {
  final _ObservableCounter _counter = _ObservableCounter();
  
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
            // Simula a ação de incrementar o contador
            _counter.increment();
          },
          child: const Text('Incrementar'),
        ),
      ],
    );
  }
}

class _ObservableCounter extends ChangeState {
  int counter = 0;

  void increment() {
    counter++;
    notifyCallback();
  }
}