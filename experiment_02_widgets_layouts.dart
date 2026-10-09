import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Widgets Experiment',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Experiment 2: Widgets'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to Flutter!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'This is a Container widget.',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home, size: 40, color: Colors.blue),
                  Icon(Icons.favorite, size: 40, color: Colors.red),
                  Icon(Icons.star, size: 40, color: Colors.orange),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Column Layout',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('First item'),
                  Text('Second item'),
                  Text('Third item'),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Stack Layout',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 100,
                        color: Colors.blue,
                      ),
                      const Icon(
                        Icons.flutter_dash,
                        size: 60,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Image.network(
                'https://picsum.photos/300/150',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Image could not be loaded.');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
