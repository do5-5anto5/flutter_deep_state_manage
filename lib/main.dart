import 'package:flutter/material.dart';
import 'package:flutter_deep_state_manage/presentation/controllers/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

final themeController = ThemeController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme:
              themeController.isDarkTheme
                  ? ThemeData.dark()
                  : ThemeData.light(),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Change Notifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Trocar tema do aplicativo'),
            ListenableBuilder(
              listenable: themeController,
              builder: (context, child) {
                return Switch(
                  value: themeController.isDarkTheme,
                  onChanged: (value) {
                    themeController.toggleTheme();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
