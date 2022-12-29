import 'package:flutter/material.dart';
import 'package:flutter_memory_game/screens/flip_card_screen.dart';
import 'package:lottie/lottie.dart';

class StartGameScreen extends StatefulWidget {
  const StartGameScreen({super.key});

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
          "Flutter Memory Game",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            LottieBuilder.asset(
              "assets/brain_animation.json",
            ),
            const SizedBox(
              height: 40,
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
            )
          ],
        ),
      ),
    );
  }
}
