import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

// Define the ChangeNotifierProvider for the CounterProvider
final counterProvider = ChangeNotifierProvider((ref) => CounterProvider());

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtain the current value of the counter using ref.watch
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Riverpod Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter Value:',
            ),
            Text(
              '${counter.counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            // Call the increment method of CounterProvider when FloatingActionButton is pressed
            onPressed: () => ref.read(counterProvider).increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            // Call the decrement method of CounterProvider when FloatingActionButton is pressed
            onPressed: () => ref.read(counterProvider).decrement(),
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // Notify listeners of the state change
  }

  void decrement() {
    _counter--;
    notifyListeners(); // Notify listeners of the state change
  }
}
