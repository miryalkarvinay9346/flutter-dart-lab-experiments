import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

// Provider-based state management
class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'State Management Experiment',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int localCount = 0;

  @override
  Widget build(BuildContext context) {
    final providerCount = context.watch<CounterProvider>().count;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 5: State Management'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '1. StatefulWidget + setState()',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Local Count: $localCount',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        localCount++;
                      });
                    },
                    child: const Text('Increment'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        localCount = 0;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const Divider(height: 40),
              const Text(
                '2. Provider State Management',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Provider Count: $providerCount',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterProvider>().increment();
                    },
                    child: const Text('Increment'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterProvider>().decrement();
                    },
                    child: const Text('Decrement'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterProvider>().reset();
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'StatelessWidget displays UI without storing mutable state of its own.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
