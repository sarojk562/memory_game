import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/providers/user_data.dart';
import 'package:flutter_memory_game/views/game_screen.dart';
import 'package:flutter_memory_game/views/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StartGameScreen extends StatefulWidget {
  const StartGameScreen({Key? key}) : super(key: key);

  @override
  State<StartGameScreen> createState() => _StartGameScreenState();
}

class _StartGameScreenState extends State<StartGameScreen> {
  setLogout() {
    FirebaseAuth.instance.signOut().then((value) => {log('Logout successful')});
    final dataProvider = Provider.of<UserData>(context, listen: false);
    dataProvider.removeUser();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "NAU: Memory Match Game",
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
                  builder: (context) => const MyFlipCardGame(),
                ),
              );
            },
            child: const Text("Start Game"),
          ),
          ElevatedButton(
            onPressed: setLogout,
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
}
