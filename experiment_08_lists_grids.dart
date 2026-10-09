import 'package:flutter/material.dart';

void main() {
  runApp(const ListsGridsApp());
}

class ListsGridsApp extends StatelessWidget {
  const ListsGridsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lists and Grids Experiment',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const ListsGridsScreen(),
    );
  }
}

class ListsGridsScreen extends StatelessWidget {
  const ListsGridsScreen({super.key});

  final List<String> fruits = const [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Grapes',
    'Pineapple',
  ];

  final List<IconData> fruitIcons = const [
    Icons.apple,
    Icons.eco,
    Icons.circle,
    Icons.spa,
    Icons.grass,
    Icons.park,
  ];

  final List<Color> colors = const [
    Colors.red,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.purple,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 8: Lists and Grids'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '1. ListView.builder',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('A scrollable list of fruit items.'),
          const SizedBox(height: 12),

          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colors[index].withAlpha(40),
                      child: Icon(
                        fruitIcons[index],
                        color: colors[index],
                      ),
                    ),
                    title: Text(fruits[index]),
                    subtitle: Text('Fruit item ${index + 1}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'You selected ${fruits[index]}',
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            '2. GridView.builder',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('A grid of colorful fruit cards.'),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fruits.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              return Card(
                color: colors[index].withAlpha(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      fruitIcons[index],
                      size: 42,
                      color: colors[index],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      fruits[index],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
