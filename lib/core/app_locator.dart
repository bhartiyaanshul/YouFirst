import 'package:get_it/get_it.dart';
import 'package:youfirst/core/app_router.dart';
import 'package:youfirst/core/service/auth_service.dart';
import 'package:youfirst/core/service/speech_to_text.dart';
import 'package:youfirst/core/service/text_to_speech.dart';

GetIt locator = GetIt.instance;

void setuplocator() {
  locator.registerSingleton(AppRouter());
  locator.registerSingleton(AuthService());
  locator.registerSingleton(TextToSpeechService());
  locator.registerSingleton(SpeechToTextService());
  }
