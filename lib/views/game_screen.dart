import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/model/data.dart';
import 'package:flutter_memory_game/services/get_user_data.dart';
import 'package:flutter_memory_game/views/game_over_screen.dart';
import 'package:flutter_memory_game/views/login_screen.dart';
import 'package:flutter_memory_game/views/start_game_screen.dart';

class MyFlipCardGame extends StatefulWidget {
  const MyFlipCardGame({super.key});

  @override
  State<MyFlipCardGame> createState() => _MyFlipCardGameState();
}

class _MyFlipCardGameState extends State<MyFlipCardGame> {
  int _previousIndex = -1;
  int _time = 3;
  int gameDuration = -3;
  bool _flip = false;
  bool _start = false;
  bool _wait = false;
  bool _isFinished = false;
  Timer _timer = Timer(Duration.zero, () {});
  Timer _durationTimer = Timer(Duration.zero, () {});
  int _left = 0;
  User? user;
  Map<String, dynamic>? userData = {};
  List _data = [];
  List<bool> _cardFlips = [];
  List<GlobalKey<FlipCardState>> _cardStateKeys = [];

  @override
  void initState() {
    super.initState();
    fetchUserDataAndInitializeGame();
  }

  Future<void> fetchUserDataAndInitializeGame() async {
    user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
      return;
    } else if (user != null && user?.email != null) {
      final userEmail = user?.email;
      if (userEmail != null && userEmail.isNotEmpty) {
        userData = await getUserData(userEmail);
      }
      log('Fetched userData: $userData');
      initializeGameData(userData); // Now passing fetched userData
      startTimer();
      startDuration();
      startGameAfterDelay();
    }
  }

  void initializeGameData(Map<String, dynamic>? userData) {
    if (userData != null) {
      log('${userData["user_level"]}');
      log('${userData["day"]}');
      log('${userData["hasPlayedToday"]}');

      switch (userData['user_level']) {
        case 1:
          // Code for level 1
          imagePath = levelOneImagePath;
          _data = userData["hasPlayedToday"]
              ? createShuffledListFromImageSource()
              : level1Images[userData['day'] % 7];
          break;
        case 2:
          // Code for level 2
          imagePath = levelTwoImagePath;
          _data = userData["hasPlayedToday"]
              ? createShuffledListFromImageSource()
              : level2Images[userData['day'] % 7];
          break;
        case 3:
          // Code for level 3
          imagePath = levelThreeImagePath;
          _data = userData["hasPlayedToday"]
              ? createShuffledListFromImageSource()
              : level3Images[userData['day'] % 7];
          break;
        default:
          // Code for other levels
          break;
      }
    } else {
      imagePath = levelOneImagePath;
      _data = createShuffledListFromImageSource();
    }

    _cardFlips = getInitialItemStateList();
    _cardStateKeys = createFlipCardStateKeysList();
    _time = 3;
    _left = (_data.length ~/ 2);
    _isFinished = false;
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _time = (_time - 1);
      });
    });
  }

  void startDuration() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        gameDuration = (gameDuration + 1);
      });
    });
  }

  void startGameAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _durationTimer.cancel();
    super.dispose();
  }

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(_data[index])),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return _isFinished
        ? GameOverScreen(
            duration: gameDuration,
            userLevel: userData?["user_level"],
            userEmail: user?.email)
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: "Level: ${userData?["user_level"]}",
                        style: theme.bodyLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Remaining: $_left',
                            style: theme.bodyMedium,
                          ),
                          Text(
                            'Duration: ${gameDuration}s',
                            style: theme.bodyMedium,
                          ),
                          Text(
                            'Countdown: $_time',
                            style: theme.bodyMedium,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    GridView.builder(
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (context, index) => _start
                          ? FlipCard(
                              key: _cardStateKeys[index],
                              onFlip: () {
                                if (!_flip) {
                                  _flip = true;
                                  _previousIndex = index;
                                } else {
                                  _flip = false;
                                  if (_previousIndex != index) {
                                    if (_data[_previousIndex] != _data[index]) {
                                      _wait = true;

                                      Future.delayed(
                                          const Duration(milliseconds: 1500),
                                          () {
                                        _cardStateKeys[_previousIndex]
                                            .currentState!
                                            .toggleCard();
                                        _previousIndex = index;
                                        _cardStateKeys[_previousIndex]
                                            .currentState!
                                            .toggleCard();

                                        Future.delayed(
                                            const Duration(milliseconds: 160),
                                            () {
                                          setState(() {
                                            _wait = false;
                                          });
                                        });
                                      });
                                    } else {
                                      _cardFlips[_previousIndex] = false;
                                      _cardFlips[index] = false;
                                      log("$_cardFlips");
                                      setState(() {
                                        _left -= 1;
                                      });
                                      if (_cardFlips.every((t) => t == false)) {
                                        log("Won!");
                                        Future.delayed(
                                            const Duration(milliseconds: 160),
                                            () {
                                          setState(() {
                                            _isFinished = true;
                                            _start = false;
                                          });
                                          _durationTimer.cancel();
                                        });
                                      }
                                    }
                                  }
                                }
                                setState(() {});
                              },
                              flipOnTouch: _wait ? false : _cardFlips[index],
                              direction: FlipDirection.HORIZONTAL,
                              front: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/image_cover.jpg",
                                    ),
                                  ),
                                ),
                                margin: const EdgeInsets.all(4.0),
                              ),
                              back: getItem(index))
                          : getItem(index),
                      itemCount: _data.length,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StartGameScreen(),
                          ),
                        );
                      },
                      child: const Text("Close Game"),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
