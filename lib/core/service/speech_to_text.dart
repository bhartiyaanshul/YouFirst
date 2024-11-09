import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService extends ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _recognizedWords = '';  // Holds the recognized speech.

  bool get isListening => _speechToText.isListening;
  bool get speechEnabled => _speechEnabled;
  String get recognizedWords => _recognizedWords;  // Full recognized words

  /// Initializes the SpeechToText service
  Future<void> initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    notifyListeners(); // Notify listeners when initialized
    log(isListening.toString());
  }

  /// Starts a speech recognition session
  Future<void> startListening() async {
    _recognizedWords = '';  // Clear recognized words at the start of a new session
    await _speechToText.listen(onResult: _onSpeechResult);
    notifyListeners(); // Notify when listening starts
  }

  /// Stops the active speech recognition session
  Future<void> stopListening() async {
    await _speechToText.stop();
    notifyListeners(); // Notify when listening stops
  }

  /// Callback that updates the recognized speech
  void _onSpeechResult(SpeechRecognitionResult result) {
    log("Recognized speech: ${result.recognizedWords}");

    // Append recognized words to the full recognized speech
    _recognizedWords = result.recognizedWords;
    notifyListeners(); // Notify listeners when new speech is recognized
  }
}