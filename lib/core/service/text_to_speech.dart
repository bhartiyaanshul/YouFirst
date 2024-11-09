import 'package:http/http.dart' as http;
import 'dart:convert';

class TextToSpeechService {
  final String apiKey = 'sk_aafa3a83cbb7cd95b97552f8655d4855059c618014ace273';
  final String voiceId = 'https://api.elevenlabs.io/v1/voices';

  Future<String> textToSpeech(String text) async {
    final url = Uri.parse('https://api.elevenlabs.io/v1/text-to-speech');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'text': text,
        // additional parameters here
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to generate speech');
    }
  }
}