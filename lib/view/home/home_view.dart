import 'dart:developer';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youfirst/view/home/home_view_model.dart';
import 'package:youfirst/widget/button/sentiment_button.dart';
import 'package:just_audio/just_audio.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final yt = YoutubeExplode();
  final player = AudioPlayer();
  List<String> songTitles = [];
  List<String> songUrls = [];
  bool isPlaying = false;

  String selectedMood = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchYouTubeSongs(List<String> songs) async {
    log("Fetching songs...");

    try {
      songTitles.clear();
      songUrls.clear();
      for (var term in songs) {
        final result = await yt.search.search(term);
        final videoId = result.first.id.value;
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.first.url;

        setState(() {
          songTitles.add(result.first.title);
          songUrls.add(audioUrl.toString());
        });
      }
      log("Fetched song titles: $songTitles");
    } catch (e) {
      log('Error fetching songs: $e');
    }
  }

  Future<void> playSong(String url) async {
    try {
      // Stop any currently playing audio before playing new song
      await player.stop();
      await player.setUrl(url); // Set URL of the audio
      await player.play();
      setState(() {
        isPlaying = true;
      }); // Play audio
    } catch (e) {
      log('Error playing song: $e');
    }
  }

  Future<void> stopSong() async {
    try {
      await player.stop();
      setState(() {
        isPlaying = false;
      }); // Stop audio
    } catch (e) {
      log('Error stopping song: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      builder: (context, child) {
        final model = context.watch<HomeViewModel>();
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Color(0xffAEAFF7),
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
                                  'Hi, John!',
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
                                backgroundColor: const Color(0xffEF5DA8),
                                isSelected: model.selectedMood == 'happy',
                                onPressed: () {
                                  fetchYouTubeSongs(model.happySongNames);
                                  setState(() {
                                    selectedMood =
                                        'happy'; // Update the selected mood
                                  });
                                },
                              ),
                              SentimentButton(
                                icon: Icons.sentiment_satisfied,
                                label: 'Calm',
                                backgroundColor: const Color(0xffAEAFF7),
                                isSelected: model.selectedMood == 'calm',
                                onPressed: () {
                                  fetchYouTubeSongs(model.CalmSongNames);
                                  setState(() {
                                    selectedMood =
                                        'calm'; // Update the selected mood
                                  });
                                },
                              ),
                              SentimentButton(
                                icon: Icons.sentiment_neutral,
                                label: 'Energetic',
                                backgroundColor: const Color(0xffA0E3E2),
                                isSelected: model.selectedMood == 'energetic',
                                onPressed: () {
                                  fetchYouTubeSongs(model.EnergeticSongNames);
                                  setState(() {
                                    selectedMood =
                                        'energetic'; // Update the selected mood
                                  });
                                },
                              ),
                              SentimentButton(
                                icon: Icons.sentiment_very_dissatisfied,
                                label: 'Sad',
                                backgroundColor: const Color(0xffF09E54),
                                isSelected: model.selectedMood == 'sad',
                                onPressed: () {
                                  fetchYouTubeSongs(model.SadSongNames);
                                  setState(() {
                                    selectedMood =
                                        'sad'; // Update the selected mood
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      if (selectedMood == 'happy' ||
                          selectedMood == 'calm' ||
                          selectedMood == 'energetic' ||
                          selectedMood == 'sad') ...[
                        // Show songs only when 'happy' is selected
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Text(
                                '${selectedMood.toUpperCase()} PLAYLIST',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              for (int i = 0; i < songTitles.length; i++) ...[
                                ListTile(
                                  title: Text(songTitles[i]),
                                  subtitle: const Text('Click to play'),
                                  onTap: () async {
                                    // Play the song or do something when tapped
                                    if (isPlaying) {
                                      await stopSong();
                                      setState(() {
                                        isPlaying = false;
                                      });
                                    } else {
                                      await playSong(songUrls[i]);
                                      setState(() {
                                        isPlaying = true;
                                      });
                                      log('Playing: ${songTitles[i]}');
                                    }
                                    log('Playing: ${songTitles[i]}');
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 30),
                      // The rest of your UI (1-on-1 session, journal, etc.)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.orange[300],
                          borderRadius: BorderRadius.circular(10),
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
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Let’s open up to the things that \n matter the most ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                        const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      // await model.sendMessage();
                                      model.navigateToQuestion();
                                    },
                                    child: const Text(
                                      'Start Session',
                                      style: TextStyle(
                                          color: Colors.black,
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
                          GestureDetector(
                            onTap: () {
                              // Navigate to the journal screen
                              model.navigateToJournal();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffF4F3F1),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: const Row(
                                children: [
                                  Icon(Icons.history_edu),
                                  SizedBox(width: 10),
                                  Text(
                                    'Journals',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffF4F3F1),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: const Row(
                              children: [
                                Icon(Icons.timeline),
                                SizedBox(width: 10),
                                Text(
                                  'Sessions',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // The rest of your UI (1-on-1 session, journal, etc.)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xffF09E54),
                          borderRadius: BorderRadius.circular(10),
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
                                    'Call a Therapist!',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Let’s open up to the things that \n matter the most ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                        const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      await model.sendMessage();
                                      model.navigateToQuestion();
                                    },
                                    child: const Text(
                                      'Start Session',
                                      style: TextStyle(
                                          color: Colors.black,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
