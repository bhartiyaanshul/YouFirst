import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youfirst/view/home/home_view_model.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      builder: (context, child) {
        final model = context.watch<HomeViewModel>();
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: const Color(0xff006C50).withOpacity(0.9),
                ),
                child: const SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome to YouFirst',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Hi, Surya!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // const SizedBox(height: 20),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     await model.sendMessage();
                      //   },
                      //   child: const Text('Get Started'),
                      // ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'How are you feeling today?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue,
                              child: IconButton(
                                icon:
                                    const Icon(Icons.sentiment_very_satisfied),
                                onPressed: () {},
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text('Happy'),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.orange,
                              child: IconButton(
                                icon: const Icon(Icons.sentiment_satisfied),
                                onPressed: () {},
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text('Calm'),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.green,
                              child: IconButton(
                                icon: const Icon(Icons.sentiment_dissatisfied),
                                onPressed: () {},
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text('Manic'),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.red,
                              child: IconButton(
                                icon: const Icon(
                                    Icons.sentiment_very_dissatisfied),
                                onPressed: () {},
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text('Sad'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300] ?? Colors.grey,
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        'Your mood will help us to provide you with the best content',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
