import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youfirst/view/therapy/therapy_view_model.dart';

@RoutePage()
class TherapyView extends StatelessWidget {
  const TherapyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TherapyViewModel(),
      builder: (context, _) {
        final model = context.watch<TherapyViewModel>();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        log('pause');
                      },
                      icon: const Icon(
                        Icons.pause,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff006C50),
                    ),
                    child: IconButton(
                      onPressed: () {
                        log('message');
                      },
                      icon: const Icon(Icons.mic, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  )
                ],
              ),
              const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
