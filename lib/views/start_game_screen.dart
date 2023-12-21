import 'package:flutter/material.dart';
import 'package:flutter_memory_game/providers/user_data.dart';
import 'package:flutter_memory_game/views/game_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StartGameScreen extends StatefulWidget {
  const StartGameScreen({Key? key}) : super(key: key);

  @override
  State<StartGameScreen> createState() => _StartGameScreenState();
}

class _StartGameScreenState extends State<StartGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Memory Game",
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          LottieBuilder.asset(
            "assets/brain_animation.json",
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyFlipCardGame(),
                ),
              );
            },
            child: const Text("Start Game"),
          )
        ],
      ),
    );
  }
}
