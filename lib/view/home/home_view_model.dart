import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:youfirst/core/app_locator.dart';
import 'package:youfirst/core/app_router.dart';
import 'package:youfirst/core/viewmodel/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  static const String _baseUrl = 'http://localhost:11434/api/chat';
  final _route = locator<AppRouter>();

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
      await http.post(
        Uri.parse(_baseUrl),
        headers: headers,
        body: body,
      );

      // Check if the response is successful

    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  String? _currentMood;
  String? get currentMood => _currentMood;

  String? _selectedMood;
  String? get selectedMood => _selectedMood;

  /// Play mood-based music
  Future<void> playMusic(String mood) async {
    _currentMood = mood;
    _selectedMood = mood;
    notifyListeners();

    String audioPath = _getAudioPathForMood(mood);
    if (audioPath.isNotEmpty) {
      try {
        await _audioPlayer.setAsset(audioPath);
        await _audioPlayer.play();
      } catch (e) {
        debugPrint('Error playing audio: $e');
      }
    } else {
      debugPrint('No audio available for mood: $mood');
    }
  }

  /// Pause music
  Future<void> pauseMusic() async {
    try {
      await _audioPlayer.pause();
      debugPrint('Music paused');
    } catch (e) {
      debugPrint('Error pausing audio: $e');
    }
  }

  /// Stop music
  Future<void> stopMusic() async {
    try {
      await _audioPlayer.stop();
      _currentMood = null;
      notifyListeners();
      debugPrint('Music stopped');
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
  }

  /// Get the corresponding audio path for a given mood
  String _getAudioPathForMood(String mood) {
    switch (mood) {
      case 'happy':
        return 'assets/audios/happy.mp3';
      case 'calm':
        return 'assets/audios/calm.mp3';
      case 'energetic':
        return 'assets/audios/energetic.mp3';
      case 'sad':
        return 'assets/audios/sad.mp3';
      default:
        return '';
    }
  }

  /// Handle volume adjustments
  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume);
      debugPrint('Volume set to $volume');
    } catch (e) {
      debugPrint('Error setting volume: $e');
    }
  }

  /// Dispose resources when no longer needed
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void navigateToQuestion() {
    _route.push(const QuestionRoute());
  }

  void navigateToJournal() {
    _route.push(const JournalRoute());
  }
}
