
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentTaskApp());
}

class StudentTaskApp extends StatelessWidget {
  const StudentTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Task Manager',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const TaskHomePage(),
    );
  }
}

class Task {
  final String title;
  bool isCompleted;

  Task({
    required this.title,
    this.isCompleted = false,
  });
}

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final TextEditingController _taskController =
      TextEditingController();

  final List<Task> _tasks = [
    Task(title: 'Complete Dart basics'),
    Task(title: 'Practice Flutter widgets'),
    Task(title: 'Learn state management'),
  ];

  void _addTask() {
    final title = _taskController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a task name'),
        ),
      );
      return;
    }

    setState(() {
      _tasks.add(Task(title: title));
    });

    _taskController.clear();
    FocusScope.of(context).unfocus();
  }

  void _toggleTask(int index, bool? value) {
    setState(() {
      _tasks[index].isCompleted = value ?? false;
    });
  }

  void _deleteTask(int index) {
    final removedTask = _tasks[index];

    setState(() {
      _tasks.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedTask.title} deleted'),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completedCount =
        _tasks.where((task) => task.isCompleted).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Task Manager'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Learning Goals',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$completedCount of ${_tasks.length} tasks completed',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: _tasks.isEmpty
                      ? 0
                      : completedCount / _tasks.length,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a new task',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.edit_note),
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _addTask,
                  icon: const Icon(Icons.add),
                  tooltip: 'Add task',
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Tasks',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks yet. Add your first task!',
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];

                      return Card(
                        child: CheckboxListTile(
                          value: task.isCompleted,
                          onChanged: (value) {
                            _toggleTask(index, value);
                          },
                          controlAffinity:
                              ListTileControlAffinity.leading,
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          secondary: IconButton(
                            onPressed: () => _deleteTask(index),
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            tooltip: 'Delete task',
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
