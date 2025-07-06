import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'country.dart';

class QuizProvider extends ChangeNotifier {
  int _score = 0;
  int _currentIndex = 0;
  List<Country> _countries = [];
  bool _isLoading = true;

  int get score => _score;
  int get currentIndex => _currentIndex;
  List<Country> get countries => _countries;
  bool get isLoading => _isLoading;

  QuizProvider() {
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      final url = Uri.parse('https://restcountries.com/v3.1/independent?independent=true');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        _countries = data
            .where((c) =>
                c['name'] != null &&
                c['capital'] != null &&
                c['capital'] is List &&
                c['capital'].isNotEmpty)
            .map((c) => Country(
                  name: c['name']['common'],
                  capital: c['capital'][0],
                ))
            .toList();

        _countries.shuffle();
        _countries = _countries.take(10).toList(); // 10 questions max
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Erreur chargement API : $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _score = 0;
    _currentIndex = 0;
    _countries.shuffle();
    notifyListeners();
  }

  void checkAnswer(String answer) {
    if (answer == _countries[_currentIndex].capital) {
      _score++;
    }
    _currentIndex++;
    notifyListeners();
  }

  bool get isFinished => _currentIndex >= _countries.length;
}
