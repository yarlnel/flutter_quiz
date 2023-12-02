
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

  static Quiz empty() => Quiz(
      title: "hah",
      answer: QuestionAnswer.A,
      a: "",
      b: "",
      c: "",
      d: ""
  );

  @override
  String toString() =>
      '$title\n'
      'answer: $answer\n'
      'a: $a\n'
      'b: $b\n'
      'd: $d\n'
      'c: $c\n'
      '\n\n\n';
}
