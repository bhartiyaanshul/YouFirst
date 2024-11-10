import 'dart:convert';
import 'dart:developer';

import 'package:youfirst/core/app_locator.dart';
import 'package:youfirst/core/app_router.dart';
import 'package:youfirst/core/viewmodel/base_view_model.dart';
import 'package:http/http.dart' as http;

class QuestionViewModel extends BaseViewModel {
  static const String _baseUrl = 'http://10.0.2.2:11434/api/chat';
  var command = '';
  final List<Map<String, List<String>>> questionsWithOptions = [
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
    {
      "How often do you exercise in a week?": [
        "Every day",
        "A few times a week",
        "Once a week",
        "Rarely",
        "Never"
      ],
    },
  ];

  final _route = locator<AppRouter>();

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

  Future<String?> sendMessage() async {
    try {
      print('Sending message to the API...');
      // Define the headers for the request
      final headers = {'Content-Type': 'application/json'};

      // Define the body with the required structure
      final body = jsonEncode({
        "model": "llama3.2:1b",
        "messages": [
          {
            "role": "system",
            "content":
                "You are a compassionate and understanding mental health therapist designed to support users in managing stress, anxiety, and other emotional challenges."
          },
          {
            "role": "system",
            "content":
                "Guidelines to follow: Always start by acknowledging the user’s feelings or experiences to build empathy."
          },
          {
            "role": "system",
            "content":
                "Offer supportive guidance, gentle prompts, and evidence-based coping strategies. Aim to create a safe space for users to open up."
          },
          {
            "role": "system",
            "content":
                "Avoid using overly clinical terms unless the user requests them, and keep language positive and encouraging."
          },
          {
            "role": "system",
            "content":
                "If asked for coping strategies, suggest practical methods like grounding exercises, deep breathing, journaling, or mindfulness, with brief explanations."
          },
          {
            "role": "system",
            "content":
                "If a user shares something particularly distressing, reassure them and gently recommend reaching out to a professional if they haven’t already."
          },
          {
            "role": "system",
            "content":
                "Note: Keep responses warm, concise, and non-judgmental. Show understanding, and invite users to share more if they feel comfortable."
          },
          {
            "role": "system",
            "content":
                "Note: Keep the reponse short and simple. If the user needs more information, they will ask."
          },
          {
            "role": "system",
            "content":
                "Do not use newlines (\n), tabs, or any special characters in your response. Keep it as a single, continuous paragraph."
          },
          {
            "role": "assistant",
            "content": {
              "On a scale of 1 to 5, how stressed or overwhelmed do you feel right now?":
                  ["1", "2", "3", "4", "5"],
            }
          },
          {
            "role": "user",
            "content": selectedAnswer?[0],
          },
          {
            "role": "assistant",
            "content": {
              "Have you been able to sleep well and feel rested lately?": [
                "Yes, I feel well-rested",
                "No, I’ve been struggling with sleep",
                "Sometimes, but not consistently",
                "I sleep too much but still feel tired"
              ],
            }
          },
          {
            "role": "user",
            "content": selectedAnswer?[1],
          },
          {
            "role": "assistant",
            "content": {
              "What is the biggest challenge or worry on your mind today?": [
                "Work-related stress",
                "Personal relationships",
                "Health concerns",
                "Financial issues",
                "Other"
              ],
            }
          },
          {
            "role": "user",
            "content": selectedAnswer?[2],
          },
          {
            "role": "assistant",
            "content": {
              "Do you feel connected to others, or are you experiencing loneliness?":
                  [
                "I feel well-connected and supported",
                "I sometimes feel lonely but manage well",
                "I often feel lonely and disconnected",
                "I prefer being alone"
              ],
            }
          },
          {
            "role": "user",
            "content": selectedAnswer?[3],
          },
          {
            "role": "assistant",
            "content": {
              "What’s one positive thing that happened to you recently?": [
                "Achieved a personal goal",
                "Spent quality time with loved ones",
                "Received good news",
                "Learned something new",
                "Other"
              ],
            }
          },
          {
            "role": "user",
            "content": selectedAnswer?[4],
          },
          {
            "role": "assistant",
            "content": {
              "How often do you exercise in a week?": [
                "Every day",
                "A few times a week",
                "Once a week",
                "Rarely",
                "Never"
              ],
            }
          },
          {
            "role": "user",
            "content": selectedAnswer?[5],
          },
        ],
        "stream": false
      });

      command = body;

      // Send the POST request
      await http.post(
        Uri.parse(_baseUrl),
        headers: headers,
        body: body,
      );

      log('Message sent successfully');

      // Check if the response is successful
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
    return null;
  }

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
        navigateToTherapy();
        notifyListeners();
      }
    }
  }

  bool isAnswerValid() {
    return _answers[_currentQuestionIndex]?.isNotEmpty ?? false;
  }

  Future<void> navigateToTherapy() async {
    await sendMessage();
    _route.push(TherapyRoute());
  }
}
