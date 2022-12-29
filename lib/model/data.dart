import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

List<String> imageSource() {
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

List createShuffledListFromImageSource() {
  List shuffledImages = [];
  List sourceArray = imageSource();
  for (var element in sourceArray) {
    shuffledImages.add(element);
  }
  shuffledImages.shuffle();
  return shuffledImages;
}

List<bool> getInitialItemStateList() {
  List<bool> initialItem = <bool>[];
  for (int i = 0; i < 16; i++) {
    initialItem.add(true);
  }
  return initialItem;
}

List<GlobalKey<FlipCardState>> createFlipCardStateKeysList() {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  for (int i = 0; i < 16; i++) {
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}
