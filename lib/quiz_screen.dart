import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    if (quizProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (quizProvider.isFinished) {
      return Scaffold(
        appBar: AppBar(title: const Text("Quiz terminé")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Score final: ${quizProvider.score}'),
              ElevatedButton(
                onPressed: () {
                  quizProvider.resetQuiz();
                },
                child: const Text('Rejouer'),
              )
            ],
          ),
        ),
      );
    }

    final currentCountry = quizProvider.countries[quizProvider.currentIndex];
    final options = quizProvider.countries.map((c) => c.capital).toList();
    options.shuffle();

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz des Capitales")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quelle est la capitale de ${currentCountry.name} ?',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ...options.map((capital) {
            return ElevatedButton(
              onPressed: () => quizProvider.checkAnswer(capital),
              child: Text(capital),
            );
          }).toList(),
        ],
      ),
    );
  }
}
