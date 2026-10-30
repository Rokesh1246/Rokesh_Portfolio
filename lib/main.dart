import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const RokeshPortfolioApp());
}

class RokeshPortfolioApp extends StatefulWidget {
  const RokeshPortfolioApp({super.key});

  static RokeshPortfolioAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<RokeshPortfolioAppState>();

  @override
  State<RokeshPortfolioApp> createState() => RokeshPortfolioAppState();
}

class RokeshPortfolioAppState extends State<RokeshPortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  bool get isDark => _themeMode == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rokesh Govindaraj | Flutter Developer',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
