import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youfirst/core/viewmodel/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  static const String _baseUrl = 'http://localhost:11434/api/chat';

  // Function to call the API
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
        ],
        "stream": false
      });

      // Send the POST request
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: headers,
        body: body,
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the response
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse['message']['content']);
        return jsonResponse['message'] ?? 'No response from the model.';
      } else {
        print('Failed to connect to the API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
}
