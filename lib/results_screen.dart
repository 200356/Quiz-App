import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class Results extends StatelessWidget {
  const Results(this.chosenAnwers, this.restartQuiz, {super.key});

  final List<String> chosenAnwers;
  final void Function() restartQuiz;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnwers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnwers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final int numTotalQuestions = questions.length;
    final int numCorrectQuestions = summaryData.where((data) {
      return data['correct_answer'] == data['user_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have answered $numCorrectQuestions out of $numTotalQuestions questions correct!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 230, 200, 253),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            TextButton.icon(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            )
          ],
        ),
      ),
    );
  }
}
