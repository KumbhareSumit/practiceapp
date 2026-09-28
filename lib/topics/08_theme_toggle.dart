import 'package:flutter/material.dart';

class ThemeToggleScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  // we pass the global state down
  const ThemeToggleScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // accessing current theme data parameterd locally
    final currentTheme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Global Theme Lab')),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      size: 64,
                      color: currentTheme.colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isDarkMode ? 'Dark MMode Active' : 'Light Mode Active',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'toggling this switch alters the theme data globally across all app screens.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enable dark theme mode',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: isDarkMode,
                  onChanged: onThemeChanged, // triggers callback function up at root level
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
