import 'package:flutter/material.dart';
import 'package:youfirst/core/app_locator.dart';
import 'package:youfirst/core/service/text_to_speech.dart';

String EL_API_KEY = "sk_aafa3a83cbb7cd95b97552f8655d4855059c618014ace273";

class TTSWidget extends StatefulWidget {
  @override
  _TTSWidgetState createState() => _TTSWidgetState();
}

class _TTSWidgetState extends State<TTSWidget> {
  final TextEditingController _textFieldController = TextEditingController();
  final _ttsService = locator<TextToSpeechService>();
  @override
  void dispose() {
    _textFieldController.dispose();
    _ttsService.dispose();
    super.dispose();
  }

  Future<void> _handlePlayTextToSpeech() async {
    try {
      await _ttsService.playTextToSpeech(_textFieldController.text, EL_API_KEY);
      setState(() {});
    } catch (e) {
      // Handle error, e.g., show an error message to the user
      print('Error: $e');
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
              onPressed: _ttsService.isLoadingVoice ? null : _handlePlayTextToSpeech,
              child: const Icon(Icons.volume_up),
            ),
            if (_ttsService.isLoadingVoice)
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
