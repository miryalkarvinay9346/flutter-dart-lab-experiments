import 'package:flutter/material.dart';

void main() {
  runApp(const AnimationsApp());
}

class AnimationsApp extends StatelessWidget {
  const AnimationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animations Experiment',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const AnimationsScreen(),
    );
  }
}

class AnimationsScreen extends StatefulWidget {
  const AnimationsScreen({super.key});

  @override
  State<AnimationsScreen> createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleRotation() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 11: Animations'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              '1. AnimatedContainer',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tap the button to change the size, color, '
              'and shape of the container.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: _isExpanded ? 220 : 130,
                height: _isExpanded ? 160 : 110,
                decoration: BoxDecoration(
                  color: _isExpanded
                      ? Colors.orange
                      : Colors.deepPurple,
                  borderRadius: BorderRadius.circular(
                    _isExpanded ? 32 : 8,
                  ),
                ),
                child: Icon(
                  Icons.flutter_dash,
                  color: Colors.white,
                  size: _isExpanded ? 90 : 60,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleContainer,
              child: const Text('Animate Container'),
            ),

            const Divider(height: 48),

            const Text(
              '2. AnimationController and Tween',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Rotate the Flutter icon using an explicit animation.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 6.283185307,
                  child: child,
                );
              },
              child: const Icon(
                Icons.flutter_dash,
                size: 100,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _toggleRotation,
              icon: const Icon(Icons.rotate_right),
              label: const Text('Start / Reverse Rotation'),
            ),
          ],
        ),
      ),
    );
  }
}
