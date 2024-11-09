import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:youfirst/core/app_locator.dart';
import 'package:youfirst/core/service/speech_to_text.dart';

@RoutePage()
class SpeechWidgetView extends StatefulWidget {
  @override
  _SpeechWidgetState createState() => _SpeechWidgetState();
}

class _SpeechWidgetState extends State<SpeechWidgetView> {
  final _speechService = locator<SpeechToTextService>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSpeechService();
  }

  Future<void> _initializeSpeechService() async {
    try {
      await _speechService.initSpeech();
    } catch (e) {
      // Display an error message if initialization fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initializing speech service: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
        title: const Text('Speech Demo'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Recognized words:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _speechService.isListening
                            ? _speechService.recognizedWords
                            : _speechService.speechEnabled
                                ? 'Tap the microphone to start listening...'
                                : 'Speech not available',
                        style: const TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
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
          Icons.mic
        ),

      ),
    );
  }
}
