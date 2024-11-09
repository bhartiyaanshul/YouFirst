import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youfirst/core/app_locator.dart';
import 'package:youfirst/core/service/speech_to_text.dart';
import 'package:youfirst/view/therapy/therapy_view_model.dart';

@RoutePage()
class TherapyView extends StatefulWidget {
  const TherapyView({super.key});

  @override
  _TherapyViewState createState() => _TherapyViewState();
}

class _TherapyViewState extends State<TherapyView> {
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
                                onPressed: speechService.stopListening,
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