import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatefulWidget {
  const GameOverScreen({super.key});

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}ygd

class _GameOverScreenState extends State<GameOverScreen> {
  bool isConfettiPlaying = true;
  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 10),
  );

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Congratulations! You've successfully completed the Flutter memory game. Your sharp memory and quick thinking have helped you emerge victorious. Keep up the good work and keep challenging yourself as you learn Flutter and continue to improve your skills.",
                  style: theme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text("Replay Game"),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            numberOfParticles: 30,
            minBlastForce: 10,
            maxBlastForce: 20,
            blastDirectionality: BlastDirectionality.explosive,
            confettiController: _confettiController,
            gravity: 0.1,
          ),
        ],
      ),
    );
  }
}
