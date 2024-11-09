import 'package:flutter/material.dart';
import 'package:youfirst/core/app_locator.dart';
import 'package:youfirst/core/service/speech_to_text.dart';

class SpeechWidget extends StatefulWidget {
  @override
  _SpeechWidgetState createState() => _SpeechWidgetState();
}

class _SpeechWidgetState extends State<SpeechWidget> {
  final _speechService = locator<SpeechToTextService>();
  @override
  void initState() {
    super.initState();
    _initializeSpeechService();
  }


  void _initializeSpeechService() async {
    await _speechService.initSpeech();
    setState(() {});
  }

  void _toggleListening() {
    if (_speechService.isListening) {
      _speechService.stopListening();
    } else {
      _speechService.startListening();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  _speechService.isListening
                      ? '${_speechService.lastWords}'
                      : _speechService.speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleListening,
        tooltip: 'Listen',
        child: Icon(
          _speechService.isListening ? Icons.mic : Icons.mic_off,
        ),
      ),
    );
  }
}
