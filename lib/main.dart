import 'package:flutter/material.dart';
import 'package:fuel_calc/pages/home_page.dart';
import 'package:fuel_calc/pages/settings_page.dart';
import 'package:fuel_calc/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Cost Calculator',
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        "/home" : (context) => const HomePage(),
        "/settingspage" : (context) => const SettingsPage(),
      },
      home: const HomePage(),
    );
  }
}
