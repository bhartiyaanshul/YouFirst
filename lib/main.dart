import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youfirst/core/app_locator.dart';
import 'package:youfirst/core/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://htdxzrdbpmkvvcbolplc.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh0ZHh6cmRicG1rdnZjYm9scGxjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA5NTEyMTQsImV4cCI6MjA0NjUyNzIxNH0.DR7r8UZ-Fu4TYhPEPcCBsF9K1mQSqF0r1tHpCTJ8u1Q');
  setuplocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = locator<AppRouter>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'You First',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _appRouter.config());
  }
}
