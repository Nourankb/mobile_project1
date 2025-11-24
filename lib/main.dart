import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/entry_provider.dart';
import 'screen/home_screen.dart';
import 'theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EntryProvider(),
      child: EcoTrackApp(),
    ),
  );
}

class EcoTrackApp extends StatelessWidget {
  const EcoTrackApp ({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EntryProvider>(context);
    return MaterialApp(
      title: 'EcoTrack',
      theme: lightTheme, // Light theme from theme.dart
      darkTheme: darkTheme, //  Dark theme from theme.dart
      themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light, //  Dynamic switch
      home: HomeScreen(),

    );
  }
}