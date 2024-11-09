import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youfirst/view/home/home_view_model.dart';
import 'package:youfirst/widget/button/sentiment_button.dart';

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
          backgroundColor: Colors.white,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How are you feeling today?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SentimentButton(
                              icon: Icons.sentiment_very_satisfied,
                              label: 'Happy',
                              backgroundColor: Colors.blue,
                              isSelected: model.selectedMood == 'happy',
                              onPressed: () => model.playMusic('happy'),
                            ),
                            SentimentButton(
                              icon: Icons.sentiment_satisfied,
                              label: 'Calm',
                              backgroundColor: Colors.orange,
                              isSelected: model.selectedMood == 'calm',
                              onPressed: () => model.playMusic('calm'),
                            ),
                            SentimentButton(
                              icon: Icons.sentiment_neutral,
                              label: 'Energetic',
                              backgroundColor: Colors.green,
                              isSelected: model.selectedMood == 'energetic',
                              onPressed: () => model.playMusic('energetic'),
                            ),
                            SentimentButton(
                              icon: Icons.sentiment_very_dissatisfied,
                              label: 'Sad',
                              backgroundColor: Colors.red,
                              isSelected: model.selectedMood == 'sad',
                              onPressed: () => model.playMusic('sad'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color(0xff006C50).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff006C50).withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '1 on 1 session ',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff006C50),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Let’s open up to the things that \n matter the most ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Start Session',
                                    style: TextStyle(
                                        color: Color(0xff006C50),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Image.asset('assets/images/Meetup Icon.png')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffF4F3F1),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: const Row(
                            children: [
                              Icon(Icons.history),
                              SizedBox(width: 8),
                              Text(
                                'History',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffF4F3F1),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: const Row(
                            children: [
                              Icon(Icons.history),
                              SizedBox(width: 8),
                              Text(
                                'History',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xff006C50).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                              '“It is better to conquer yourself than \n to win a thousand battles”'),
                          Flexible(
                            child: Image.asset('assets/images/quote.png',
                                fit: BoxFit.cover, width: 30),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.home, color: Colors.white),
          //       label: 'Home',
          //       backgroundColor: Colors.green,
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.search, color: Colors.white),
          //       label: 'Search',
          //       // backgroundColor: Colors.green,
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.notifications, color: Colors.white),
          //       label: 'Notifications',
          //       // backgroundColor: Colors.orange,
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.person, color: Colors.white),
          //       label: 'Profile',
          //       backgroundColor: Colors.red,
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
