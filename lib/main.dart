import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_screen.dart';
import 'quiz_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz des Capitales',
      home: QuizScreen(),
    );
  }
}
