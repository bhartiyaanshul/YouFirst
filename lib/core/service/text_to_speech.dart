import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class TextToSpeechService {
  final AudioPlayer player = AudioPlayer();
  bool _isLoadingVoice = false;

  bool get isLoadingVoice => _isLoadingVoice;

  Future<void> playTextToSpeech(String text, String apiKey) async {
    _isLoadingVoice = true;

    String voiceRachel = '21m00Tcm4TlvDq8ikWAM';
    String url = 'https://api.elevenlabs.io/v1/text-to-speech/voices';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'accept': 'audio/mpeg',
        'xi-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "text": text,
        "model_id": "eleven_monolingual_v1",
        "voice_settings": {
          "stability": 0.15,
          "similarity_boost": 0.50,
          "language_code": "hi"
        }
      }),
    );

    _isLoadingVoice = false;

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      await player.setAudioSource(MyCustomSource(bytes));
      player.play();
    } else {
      throw Exception('Failed to load TTS audio');
    }
  }

  void dispose() {
    player.dispose();
  }
}

class MyCustomSource extends StreamAudioSource {
  final List<int> bytes;
  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.fromIterable([bytes.sublist(start, end)]),
      contentType: 'audio/mpeg',
    );
  }
}
