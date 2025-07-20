import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/builders/observable_buider.dart';
import 'package:flutter_deep_state_manage/classes/counter_state.dart';

import 'controllers/state_observable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterState = CounterState();
  final observableCounter = StateObservable(0);

  @override
  void initState() {
    observableCounter.addListener(callback);
    super.initState();
  }

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Flutter State Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ObservableBuider(
              observable: counterState,
              builder:
                  (context, child) => Text('Valor do estado: ${counterState.counter}'),
            ),

            ElevatedButton(
              onPressed: () {
                counterState.increment();
              },
              child: Text('Incrementar'),
            ),
            Text(
              'Valor do estado do StateObservable: ${observableCounter.state}',
            ),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    observableCounter.removeListener(callback);
    super.dispose();
  }
}
