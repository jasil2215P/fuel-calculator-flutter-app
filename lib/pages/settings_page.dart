import 'package:flutter/material.dart';
import 'package:fuel_calc/themes/dark_theme.dart';
import 'package:fuel_calc/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          ListTile(
            title: const Text("Dark Mode"),
            leading: const Icon(Icons.mode_night),
            trailing: Switch(
              value: Provider.of<ThemeProvider>(context).themeData == darkMode,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ),
        ]),
      ),
    );
  }
}
