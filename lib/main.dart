import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final t = prefs.getString('themeMode');
    setState(() {
      if (t == 'dark')
        _themeMode = ThemeMode.dark;
      else if (t == 'light')
        _themeMode = ThemeMode.light;
      else
        _themeMode = ThemeMode.system;
    });
  }

  Future<void> _setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    String val = 'system';
    if (mode == ThemeMode.dark)
      val = 'dark';
    else if (mode == ThemeMode.light)
      val = 'light';
    await prefs.setString('themeMode', val);
    setState(() => _themeMode = mode);
  }

  void _toggleLightDark() {
    final newMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    _setThemeMode(newMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Styling & Theming',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.black87),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: MyHomePage(
        themeMode: _themeMode,
        onToggleTheme: _toggleLightDark,
        onSetThemeMode: _setThemeMode,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final Future<void> Function(ThemeMode) onSetThemeMode;

  MyHomePage({
    Key? key,
    required this.themeMode,
    required this.onToggleTheme,
    required this.onSetThemeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pertemuan 10: Styling & Theming")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Teks Default Theme"),
            SizedBox(height: 8),
            Text(
              "Teks Custom Style",
              style: TextStyle(fontSize: 22, color: Colors.red),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              child: Text("Button dengan Theme"),
            ),
            SizedBox(height: 16),
            Text('Theme:', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () => onSetThemeMode(ThemeMode.light),
                      child: Text('Light'),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => onSetThemeMode(ThemeMode.system),
                      child: Text('System'),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => onSetThemeMode(ThemeMode.dark),
                      child: Text('Dark'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
