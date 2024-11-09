import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youfirst/view/question/question_view_model.dart';

@RoutePage()
class QuestionView extends StatelessWidget {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestionViewModel(),
      builder: (context, _) {
        final model = context.watch<QuestionViewModel>();
        return Scaffold(
          appBar: AppBar(
            title: const Text("Questionnaire"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  model.currentQuestion,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (model.currentQuestionIndex == 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('(Low)', style: TextStyle(fontSize: 14)),
                      ...model.currentOptions.map((option) {
                        return GestureDetector(
                          onTap: () => model.updateAnswer(option),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: model.selectedAnswer == option
                                  ? Colors.green
                                  : Colors.grey.shade300,
                            ),
                            child: Text(option,
                                style: const TextStyle(fontSize: 16)),
                          ),
                        );
                      }),
                      const Text('(High)', style: TextStyle(fontSize: 14)),
                    ],
                  )
                else
                  Expanded(
                    child: ListView(
                      children: model.currentOptions.map((option) {
                        return RadioListTile<String>(
                          title: Text(option),
                          value: option,
                          groupValue: model.selectedAnswer,
                          onChanged: (value) {
                            if (value != null) {
                              model.updateAnswer(value);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) =>
                        model.isAnswerValid() ? const Color(0xffAEAFF7) : null),
                  ),
                  onPressed: model.isAnswerValid() ? model.nextQuestion : null,
                  child: Text(
                    model.isLastQuestion ? "Submit" : "Next",
                    style: TextStyle(
                        color: model.isAnswerValid() ? Colors.white : null),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
