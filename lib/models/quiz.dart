
enum QuestionAnswer {
  A, B, C, D
}

class Quiz {
  final String title, a, b, c, d;
  final QuestionAnswer answer;

  Quiz({
    required this.title,
    required this.answer,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
  });

  @override
  String toString() =>
      '$title'
      'answer: $answer\n'
      'a: $a'
      'b: $b'
      'd: $d'
      'c: $c';
}
