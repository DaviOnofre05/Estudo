
import 'package:flutter/material.dart';
import 'package:flutter_application_2_list/componentes/theme.dart';
import 'package:flutter_application_2_list/views/homepage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        colorSchemeSeed: TestTheme.primaryColor,
      ),
      home: const Homepage(),
    );
  }
}
