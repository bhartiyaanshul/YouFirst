import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String EL_API_KEY = "sk_aafa3a83cbb7cd95b97552f8655d4855059c618014ace273";

class TTSWidget extends StatefulWidget {  
  @override
  _TTSWidgetState createState() => _TTSWidgetState();
}

class _TTSWidgetState extends State<TTSWidget> {
  final TextEditingController _textFieldController = TextEditingController();
  final player = AudioPlayer();
  bool _isLoadingVoice = false;

  @override
  void dispose() {
    _textFieldController.dispose();
    player.dispose();
    super.dispose();
  }

  Future<void> playTextToSpeech(String text) async {
    setState(() {
      _isLoadingVoice = true;
    });

    String voiceRachel = '21m00Tcm4TlvDq8ikWAM';
    String url = 'https://api.elevenlabs.io/v1/text-to-speech/$voiceRachel';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'accept': 'audio/mpeg',
        'xi-api-key': EL_API_KEY,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "text": text,
        "model_id": "eleven_monolingual_v1",
        "voice_settings": {"stability": 0.15, "similarity_boost": 0.75}
      }),
    );

    setState(() {
      _isLoadingVoice = false;
    });

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      await player.setAudioSource(MyCustomSource(bytes));
      player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EL TTS Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                labelText: 'Enter some text',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoadingVoice
                  ? null
                  : () => playTextToSpeech(_textFieldController.text),
              child: const Icon(Icons.volume_up),
            ),
            if (_isLoadingVoice)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
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