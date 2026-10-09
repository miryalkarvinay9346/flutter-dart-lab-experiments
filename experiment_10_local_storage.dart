import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const LocalStorageApp());
}

class LocalStorageApp extends StatelessWidget {
  const LocalStorageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Storage Experiment',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const StorageScreen(),
    );
  }
}

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final TextEditingController _nameController =
      TextEditingController();

  String _savedName = 'No name saved yet';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('username');

    if (!mounted) return;

    setState(() {
      _savedName = name ?? 'No name saved yet';
      _isLoading = false;
    });
  }

  Future<void> _saveName() async {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name'),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);

    if (!mounted) return;

    setState(() {
      _savedName = name;
    });

    _nameController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Name saved successfully!'),
      ),
    );
  }

  Future<void> _removeName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');

    if (!mounted) return;

    setState(() {
      _savedName = 'No name saved yet';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Saved name removed'),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 10: Local Storage'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.storage,
                size: 80,
                color: Colors.teal,
              ),
              const SizedBox(height: 20),
              const Text(
                'Shared Preferences Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _saveName,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Name'),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.account_circle,
                    color: Colors.teal,
                    size: 40,
                  ),
                  title: const Text('Saved Name'),
                  subtitle: Text(
                    _isLoading ? 'Loading...' : _savedName,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _loadName,
                icon: const Icon(Icons.refresh),
                label: const Text('Load Saved Name'),
              ),
              TextButton.icon(
                onPressed: _isLoading ? null : _removeName,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Remove Saved Name'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
