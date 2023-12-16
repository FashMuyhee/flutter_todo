import 'package:flutter/material.dart';
import 'package:todo/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.light(
            primary: Colors.teal.shade600,
            background: Colors.teal.shade50,
          ),
          appBarTheme: AppBarTheme(backgroundColor: Colors.teal.shade600)),
    );
  }
}
