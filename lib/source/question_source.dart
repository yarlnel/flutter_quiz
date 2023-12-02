import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import '../models/quiz.dart';

class QuizSource {

    static const String sourceUrl =
        "https://www.gkseries.com/sports/gk-multiple-choice-questions-and-answers";



    final dio = Dio();

    Future<List<Quiz>> getQuizzes() async {
        var response = await dio.get(sourceUrl);
        if (response.statusCode != 200) {
            throw Exception('Error: server problems');
        }

        final document = parse(response.data);

        List<Quiz> quizzes = [];

        for (Element element in document.querySelectorAll('div.mcq')) {
            var title = element
                .querySelector(
                'div.question-content, .clearfix'
            )
                ?.text ?? '';
            var options = element.querySelectorAll(
                'div.options > div.row > div.col-md-12, .option'
            );

            var optionsText = options.map((element) => element.text).toList();

            String
            a = optionsText[0],
                b = optionsText[1],
                c = optionsText[2],
                d = optionsText[3];

            String answerText = element
                .querySelector(
                'div.collapse > div.card, .card-block > blockquote'
            )
                ?.text ?? '';

            QuestionAnswer answer;

            if (answerText.contains('Answer: Option [A]')) {
                answer = QuestionAnswer.A;
            } else if (answerText.contains('Answer: Option [B]')) {
                answer = QuestionAnswer.B;
            } else if (answerText.contains('Answer: Option [C]')) {
                answer = QuestionAnswer.C;
            } else if (answerText.contains('Answer: Option [D]')) {
                answer = QuestionAnswer.D;
            } else {
                throw Exception(
                    'Parsing error, answer is not wrapped to expected template'
                );
            }

            quizzes.add(
                Quiz(
                    title: title,
                    answer: answer,
                    a: a,
                    b: b,
                    c: c,
                    d: d
                )
            );
        }
        return quizzes;
    }
}
main() async {
    var quizzes = await QuizSource().getQuizzes();
    print(quizzes.first);
}
