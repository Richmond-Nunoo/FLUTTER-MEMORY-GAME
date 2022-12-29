import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memory_game/model/data.dart';

class MyFlipCardGame extends StatefulWidget {
  const MyFlipCardGame({super.key});

  @override
  State<MyFlipCardGame> createState() => _MyFlipCardGameState();
}

class _MyFlipCardGameState extends State<MyFlipCardGame> {
  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;
  bool _wait = false;
  late Timer _timer;
  late Timer _durationTimer;
  int _time = 3;
  int _duration = -3;
  late int _left;
  late bool _isFinished;
  late List _data;
  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;

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
        _duration = (_duration + 1);
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

  void initializeGameData() {
    _data = createShuffledListFromImageSource();
    _cardFlips = getInitialItemStateList();
    _cardStateKeys = createFlipCardStateKeysList();
    _time = 3;
    _left = (_data.length ~/ 2);
    _isFinished = false;
  }

  @override
  void initState() {
    startTimer();
    startDuration();
    startGameAfterDelay();
    initializeGameData();
    super.initState();
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
        ? Scaffold(
            body: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Container(
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    "Replay",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                            'Duration: ${_duration}s',
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
                                      debugPrint("$_cardFlips");
                                      setState(() {
                                        _left -= 1;
                                      });
                                      if (_cardFlips.every((t) => t == false)) {
                                        debugPrint("Won");
                                        Future.delayed(
                                            const Duration(milliseconds: 100),
                                            () {
                                          setState(() {
                                            _isFinished = true;
                                            _start = false;
                                          });
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
                  ],
                ),
              ),
            ),
          );
  }
}
