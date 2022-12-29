import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

List<String> myfillSourceArray() {
  return [
    'assets/images/image_1.jpg',
    'assets/images/image_2.jpg',
    'assets/images/image_3.jpg',
    'assets/images/image_4.jpg',
    'assets/images/image_5.jpg',
    'assets/images/image_6.jpg',
    'assets/images/image_7.jpg',
    'assets/images/image_8.jpg',
    'assets/images/image_1.jpg',
    'assets/images/image_2.jpg',
    'assets/images/image_3.jpg',
    'assets/images/image_4.jpg',
    'assets/images/image_5.jpg',
    'assets/images/image_6.jpg',
    'assets/images/image_7.jpg',
    'assets/images/image_8.jpg',
  ];
}

List myGetSourceArray() {
  List levelAndKindList = [];
  List sourceArray = myfillSourceArray();
  for (var element in sourceArray) {
    levelAndKindList.add(element);
  }
  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> myGetInitialItemState() {
  List<bool> initialItemState = <bool>[];
  for (int i = 0; i < 16; i++) {
    initialItemState.add(true);
  }
  return initialItemState;
}


List<GlobalKey<FlipCardState>> myGetCardStateKeys() {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  for (int i = 0; i < 16; i++) {
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}
