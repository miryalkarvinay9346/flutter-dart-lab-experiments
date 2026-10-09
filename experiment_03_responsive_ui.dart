import 'package:flutter/material.dart';
void main() {
  runApp(const ResponsiveApp());
}
class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive UI Experiment',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const ResponsiveHomePage(),
    );
  }
}
class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 3: Responsive UI'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          final isTablet = constraints.maxWidth >= 600 &&
              constraints.maxWidth < 1000;
          final columns = isMobile ? 1 : (isTablet ? 2 : 3);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Responsive Flutter Layout',
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 22 : 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Screen width: ${screenWidth.toStringAsFixed(0)} pixels',
                ),
                const SizedBox(height: 8),
                Text(
                  isMobile
                      ? 'Mobile layout'
                      : isTablet
                          ? 'Tablet layout'
                          : 'Desktop layout',
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.3,
                  ),
                  itemBuilder: (context, index) {
                    final colors = [
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.purple,
                      Colors.red,
                      Colors.teal,
                    ];
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors[index].withAlpha(40),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors[index]),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.devices,
                            size: 36,
                            color: colors[index],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Card ${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
