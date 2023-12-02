import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quiz/source/question_source.dart';

import '../models/quiz.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        body: Center(child: const Text('TODO')),
      );

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<Quiz> _quizzes = List.empty();

  int _quizLevel = 0;

  Quiz _currentQuiz = Quiz.empty();

  Future<void> _fetchQuizzes() async {
    List<Quiz> quizzes = await QuizSource().getQuizzes();

    setState(() {
      _quizzes = quizzes;
      _currentQuiz = quizzes.first;
    });
  }

  @override
  void initState() {
    _fetchQuizzes();
  }

  int _score = 0;

  void _handleAnswer(QuestionAnswer answer) {
    if (_quizLevel >= (_quizzes.length - 1)) {
      _score = 0;
      return;
    }

    if (_currentQuiz.answer == answer) {
      _score++;
    }

    _quizLevel++;
    _currentQuiz = _quizzes[_quizLevel];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Text("Quiz: $_quizLevel ${_currentQuiz.title}"),
              Text("Score: $_score")
            ])),
        backgroundColor: Colors.yellowAccent,
        body: Container(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_currentQuiz.title),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () => _handleAnswer(QuestionAnswer.A),
                      child: Text(_currentQuiz.a)),
                  ElevatedButton(
                    onPressed: () => _handleAnswer(QuestionAnswer.B),
                    child: Text(_currentQuiz.b),
                  ),
                  ElevatedButton(
                      onPressed: () => _handleAnswer(QuestionAnswer.C),
                      child: Text(_currentQuiz.c)),
                  ElevatedButton(
                      onPressed: () => _handleAnswer(QuestionAnswer.D),
                      child: Text(_currentQuiz.d)),
                ])));
  }
}
