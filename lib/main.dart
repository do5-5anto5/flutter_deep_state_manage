import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/builders/observable_buider.dart';
import 'package:flutter_deep_state_manage/builders/observable_state_builder.dart';
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
          // Como usar o ObservableBuilder e o escutar um estado inteiro (semelhante ao ListenableBuilder
          children: [
            // Como usar o ObservableStateBuilder e escutar um estado inteiro (semelhante ao ValueListenableBuilder)
            // Aqui, o buildWhen é usado para determinar se o widget deve ser reconstruído
            // e o listener é usado para executar uma ação quando o estado muda
            ObservableStateBuilder(
              stateObservable: observableCounter,
              buildWhen: (oldState, newState) {
                return oldState != newState;
              },
              listener: (context, newState) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                if (newState % 2 == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Estado atualizado: $newState'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              builder:
                  (context, state, child) =>
                      Text('Valor do estado do observableCounter: $state'),
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
