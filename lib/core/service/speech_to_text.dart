import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  bool get isListening => _speechToText.isListening;
  bool get speechEnabled => _speechEnabled;
  String get lastWords => _lastWords;

  /// Initializes the SpeechToText service
  Future<void> initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  /// Starts a speech recognition session
  Future<void> startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  /// Stops the active speech recognition session
  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  /// Callback that updates the last recognized words
  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
  }
}
