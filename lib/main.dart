import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/builders/observable_buider.dart';
import 'package:flutter_deep_state_manage/builders/observable_state_builder.dart';
import 'package:flutter_deep_state_manage/classes/counter_state.dart';
import 'package:flutter_deep_state_manage/mixins/chate_state_mixin.dart';

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

class _MyHomePageState extends State<MyHomePage> with ChangeStateMixin {
  final counterState = CounterState();
  final observableCounter = StateObservable(0);
  late StateObservable<int> newMixinCounter;

  @override
  void initState() {
    useChangeState(counterState);
    useChangeState(observableCounter);
    newMixinCounter = useStateObservable(0);
    super.initState();
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
          // Como usar o ObservableBuilder e o escutar um estado inteiro (semelhante ao ListenableBuilder
          children: [
            Text('Valor do counterState: ${counterState.counter}'),
            ElevatedButton(
              onPressed: () {
                counterState.increment();
              },
              child: Text('Incrementar'),
            ),
            Text('Valor do observableCounter: ${observableCounter.state}'),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: Text('Incrementar'),
            ),
            Text('Valor do newMixinCounter: ${newMixinCounter.state}'),
            ElevatedButton(
              onPressed: () {
                newMixinCounter.state++;
              },
              child: Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
