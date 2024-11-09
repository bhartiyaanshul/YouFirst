import 'package:youfirst/core/viewmodel/base_view_model.dart';

class QuestionViewModel extends BaseViewModel {
  final List<Map<String, List<String>>> questionsWithOptions = [
    {
      "How would you describe your current emotional state in one word?": [
        "Happy",
        "Sad",
        "Anxious",
        "Calm",
        "Angry",
        "Neutral"
      ],
    },
    {
      "On a scale of 1 to 5, how stressed or overwhelmed do you feel right now?":
          ["1", "2", "3", "4", "5"],
    },
    {
      "Have you been able to sleep well and feel rested lately?": [
        "Yes, I feel well-rested",
        "No, I’ve been struggling with sleep",
        "Sometimes, but not consistently",
        "I sleep too much but still feel tired"
      ],
    },
    {
      "What is the biggest challenge or worry on your mind today?": [
        "Work-related stress",
        "Personal relationships",
        "Health concerns",
        "Financial issues",
        "Other"
      ],
    },
    {
      "Do you feel connected to others, or are you experiencing loneliness?": [
        "I feel well-connected and supported",
        "I sometimes feel lonely but manage well",
        "I often feel lonely and disconnected",
        "I prefer being alone"
      ],
    },
    {
      "What’s one positive thing that happened to you recently?": [
        "Achieved a personal goal",
        "Spent quality time with loved ones",
        "Received good news",
        "Learned something new",
        "Other"
      ],
    },
  ];

  int _currentQuestionIndex = 0;
  final Map<int, String> _answers = {};

  int get currentQuestionIndex => _currentQuestionIndex;
  String get currentQuestion =>
      questionsWithOptions[_currentQuestionIndex].keys.first;
  List<String> get currentOptions =>
      questionsWithOptions[_currentQuestionIndex].values.first;

  String? get selectedAnswer => _answers[_currentQuestionIndex];

  bool get isLastQuestion =>
      _currentQuestionIndex == questionsWithOptions.length - 1;

  void updateAnswer(String answer) {
    _answers[_currentQuestionIndex] = answer;
    notifyListeners();
  }

  void nextQuestion() {
    if (_answers[_currentQuestionIndex]?.isNotEmpty ?? false) {
      if (!isLastQuestion) {
        _currentQuestionIndex++;
        notifyListeners();
      } else {
        // All questions completed
        notifyListeners();
      }
    }
  }

  bool isAnswerValid() {
    return _answers[_currentQuestionIndex]?.isNotEmpty ?? false;
  }
}
