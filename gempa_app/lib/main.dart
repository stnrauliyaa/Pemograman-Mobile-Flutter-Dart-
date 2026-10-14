import 'package:flutter/material.dart';

import 'ui/screens/earthquake_screen.dart';
import 'ui/widgets/app_theme.dart';

void main() => runApp(const GempaApp());

class GempaApp extends StatefulWidget {
  const GempaApp({super.key});

  @override
  State<GempaApp> createState() => _GempaAppState();
}

class _GempaAppState extends State<GempaApp> {
  ThemeMode _mode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gempa Terkini',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _mode,
      home: EarthquakeScreen(
        isDark: _mode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
