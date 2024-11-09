import 'dart:convert';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youfirst/core/app_locator.dart';
import 'package:youfirst/core/service/speech_to_text.dart';
import 'package:youfirst/view/therapy/therapy_view_model.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class TherapyView extends StatefulWidget {
  const TherapyView({super.key});

  @override
  _TherapyViewState createState() => _TherapyViewState();
}

class _TherapyViewState extends State<TherapyView> {
  final _speechService = locator<SpeechToTextService>();
  // static const String _baseUrl = 'http://192.168.254.175:11434/api/chat';
  static const String _baseUrl = 'http://10.0.2.2:11434/api/chat';
  String _aiModelReponse = '';
  String get aiModelReponse => _aiModelReponse;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSpeechService();
  }

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
          {"role": "user", "content": _speechService.recognizedWords}
        ],
        "stream": false
      });

      // Send the POST request
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: headers,
        body: body,
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the response

        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        _aiModelReponse = jsonResponse['message']['content'] ?? 'No response from the model.';
        print(jsonResponse['message']['content']);
        return jsonResponse['message']['content'] ?? 'No response from the model.';
      } else {
        print('Failed to connect to the API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }

  Future<void> _initializeSpeechService() async {
    try {
      await _speechService.initSpeech();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error initializing speech service: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleListening() async {
    if (_speechService.isListening) {
      log("Mic is listening!!");
      _speechService.stopListening();
    } else {
      log("Mic isn't listening!!");
      _speechService.startListening();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TherapyViewModel(),
      builder: (context, _) {
        return ChangeNotifierProvider(
          create: (_) => SpeechToTextService(), // Add this provider
          child: Builder(
            builder: (context) {
              final speechService = context.watch<SpeechToTextService>();
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(),
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      height: 200,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            speechService.recognizedWords.isNotEmpty
                                ? speechService.recognizedWords
                                : 'Turn on the mic and say something',
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff006C50),
                              ),
                              child: IconButton(
                                onPressed: speechService.startListening,
                                icon: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff006C50),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  speechService.stopListening();
                                  await sendMessage();
                                },
                                icon: const Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
