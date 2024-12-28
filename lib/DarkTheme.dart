import 'package:fire/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkTheme extends StatefulWidget {
  const DarkTheme({super.key});

  @override
  State<DarkTheme> createState() => _DarkThemeState();
}

class _DarkThemeState extends State<DarkTheme> {
  @override
  Widget build(BuildContext context) {
    final themeChangers = Provider.of<themeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("theme"),
      ),
      body: Column(
        children: [
             RadioListTile<ThemeMode>(
              title: const Text("light"),
              value: ThemeMode.light,
              groupValue: themeChangers.themeMode,
              onChanged: themeChangers.setthememode),
             RadioListTile<ThemeMode>(
              title: const Text("dark"),
              value: ThemeMode.dark,
              groupValue: themeChangers.themeMode,
              onChanged: themeChangers.setthememode),
          RadioListTile<ThemeMode>(
              title: const Text("Sytem"),
              value: ThemeMode.system,
              groupValue: themeChangers.themeMode,
              onChanged: themeChangers.setthememode),
        ],
      ),
    );
  }
}
