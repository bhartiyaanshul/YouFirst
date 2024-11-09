import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class TextToSpeechService {
  final String apiKey = 'sk_aafa3a83cbb7cd95b97552f8655d4855059c618014ace273';
  final String voiceId = 'https://api.elevenlabs.io/v1/voices';

  Future<void> textToSpeech(String text) async {
    final url = Uri.parse('https://api.elevenlabs.io/v1/text-to-speech/$voiceId');

    final headers = {
      'xi-api-key': apiKey,
      'Accept': 'audio/mpeg',
      'Content-Type': 'application/json',
    };

    final body = {
      'text': text,
      'model_id': 'eleven_monolingual_v1', // specify the model you want to use
      'voice_settings': {
        'stability': 1.0,
        'similarity_boost': 1.0,
      },
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final Directory dir = await getApplicationDocumentsDirectory();
        final String filePath = '${dir.path}/output.mp3';

        // Write the response body as bytes to an mp3 file
        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        print('Audio file saved at $filePath');
      } else {
        print('Error: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}