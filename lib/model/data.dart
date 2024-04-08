import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

String imagePath = levelOneImagePath;
const levelOneImagePath = 'assets/images/level_one_images';
const levelTwoImagePath = 'assets/images/level_two_images';
const levelThreeImagePath = 'assets/images/level_three_images';

List<String> imageSource() {
  return [
    '$imagePath/image_1.png',
    '$imagePath/image_2.png',
    '$imagePath/image_3.png',
    '$imagePath/image_4.png',
    '$imagePath/image_5.png',
    '$imagePath/image_6.png',
    '$imagePath/image_7.png',
    '$imagePath/image_8.png',
    '$imagePath/image_1.png',
    '$imagePath/image_2.png',
    '$imagePath/image_3.png',
    '$imagePath/image_4.png',
    '$imagePath/image_5.png',
    '$imagePath/image_6.png',
    '$imagePath/image_7.png',
    '$imagePath/image_8.png',
  ];
}

List<String> list1 = [
  "$imagePath/image_6.png",
  "$imagePath/image_3.png",
  "$imagePath/image_1.png",
  "$imagePath/image_8.png",
  "$imagePath/image_7.png",
  "$imagePath/image_4.png",
  "$imagePath/image_2.png",
  "$imagePath/image_5.png",
  "$imagePath/image_8.png",
  "$imagePath/image_4.png",
  "$imagePath/image_7.png",
  "$imagePath/image_3.png",
  "$imagePath/image_1.png",
  "$imagePath/image_5.png",
  "$imagePath/image_6.png",
  "$imagePath/image_2.png"
];

List<String> list2 = [
  "$imagePath/image_7.png",
  "$imagePath/image_1.png",
  "$imagePath/image_3.png",
  "$imagePath/image_2.png",
  "$imagePath/image_5.png",
  "$imagePath/image_2.png",
  "$imagePath/image_8.png",
  "$imagePath/image_4.png",
  "$imagePath/image_8.png",
  "$imagePath/image_5.png",
  "$imagePath/image_6.png",
  "$imagePath/image_6.png",
  "$imagePath/image_3.png",
  "$imagePath/image_4.png",
  "$imagePath/image_1.png",
  "$imagePath/image_7.png"
];

List<String> list3 = [
  "$imagePath/image_5.png",
  "$imagePath/image_7.png",
  "$imagePath/image_4.png",
  "$imagePath/image_3.png",
  "$imagePath/image_6.png",
  "$imagePath/image_2.png",
  "$imagePath/image_4.png",
  "$imagePath/image_1.png",
  "$imagePath/image_1.png",
  "$imagePath/image_7.png",
  "$imagePath/image_8.png",
  "$imagePath/image_5.png",
  "$imagePath/image_6.png",
  "$imagePath/image_3.png",
  "$imagePath/image_8.png",
  "$imagePath/image_2.png",
];

List<String> list4 = [
  "$imagePath/image_7.png",
  "$imagePath/image_5.png",
  "$imagePath/image_6.png",
  "$imagePath/image_1.png",
  "$imagePath/image_1.png",
  "$imagePath/image_8.png",
  "$imagePath/image_5.png",
  "$imagePath/image_3.png",
  "$imagePath/image_2.png",
  "$imagePath/image_6.png",
  "$imagePath/image_3.png",
  "$imagePath/image_4.png",
  "$imagePath/image_4.png",
  "$imagePath/image_8.png",
  "$imagePath/image_2.png",
  "$imagePath/image_7.png",
];

List<String> list5 = [
  "$imagePath/image_2.png",
  "$imagePath/image_1.png",
  "$imagePath/image_8.png",
  "$imagePath/image_4.png",
  "$imagePath/image_2.png",
  "$imagePath/image_3.png",
  "$imagePath/image_4.png",
  "$imagePath/image_3.png",
  "$imagePath/image_8.png",
  "$imagePath/image_6.png",
  "$imagePath/image_5.png",
  "$imagePath/image_7.png",
  "$imagePath/image_5.png",
  "$imagePath/image_6.png",
  "$imagePath/image_1.png",
  "$imagePath/image_7.png",
];

List<String> list6 = [
  "$imagePath/image_8.png",
  "$imagePath/image_8.png",
  "$imagePath/image_5.png",
  "$imagePath/image_1.png",
  "$imagePath/image_5.png",
  "$imagePath/image_7.png",
  "$imagePath/image_3.png",
  "$imagePath/image_6.png",
  "$imagePath/image_7.png",
  "$imagePath/image_2.png",
  "$imagePath/image_3.png",
  "$imagePath/image_6.png",
  "$imagePath/image_1.png",
  "$imagePath/image_4.png",
  "$imagePath/image_4.png",
  "$imagePath/image_2.png",
];

List<String> list7 = [
  "$imagePath/image_6.png",
  "$imagePath/image_2.png",
  "$imagePath/image_2.png",
  "$imagePath/image_6.png",
  "$imagePath/image_8.png",
  "$imagePath/image_7.png",
  "$imagePath/image_5.png",
  "$imagePath/image_7.png",
  "$imagePath/image_3.png",
  "$imagePath/image_4.png",
  "$imagePath/image_4.png",
  "$imagePath/image_1.png",
  "$imagePath/image_1.png",
  "$imagePath/image_3.png",
  "$imagePath/image_5.png",
  "$imagePath/image_8.png",
];

List<List<String>> level1Images = [
  list1,
  list2,
  list3,
  list4,
  list5,
  list6,
  list7,
];

List<List<String>> level2Images = [
  list3,
  list1,
  list7,
  list5,
  list4,
  list6,
  list2,
];

List<List<String>> level3Images = [
  list7,
  list6,
  list2,
  list1,
  list3,
  list5,
  list4,
];

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
