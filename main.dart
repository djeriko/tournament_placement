import 'dart:collection';

import 'results.dart';

void main() {
  List<Map<int, List<String>>> randoms = [
    random_10_04,
    random_11_04,
    random_12_04,
    random_13_04,
    random_14_04,
    random_15_04,
    random_18_04,
    random_19_04,
    random_22_04,
    random_23_04,
    random_24_04
  ];

  Map<String, List<int>> tempMain = {};

  for (Map<int, List<String>> element in randoms) {
    tempMain = mergeMaps(tempMain, placeCounter(element));
  }

  LinkedHashMap scores = scoreCounter(tempMain);

  for (String key in tempMain.keys) {
    print("$key :" + " ${tempMain[key]}");
  }

  for (String key in scores.keys) {
    print("$key :" + " ${scores[key]}");
  }
}

Map<String, List<int>> placeCounter(Map<int, List<String>> values) {
  Map<String, List<int>> placement = {};
  for (int i = 1; i < values.length; i++) {
    for (int j = 0; j < 4; j++) {
      List<int> place = List.filled(10, 0);
      place[i - 1] = 1;
      placement.addAll({values[i][j]: place});
    }
  }
  return placement;
}

List<int> mergeLists(List<int> firstList, List<int> secondList) {
  for (int i = 0; i < secondList.length; i++) {
    firstList[i] = firstList[i] + secondList[i];
  }
  return firstList;
}

Map<String, List<int>> mergeMaps(
    Map<String, List<int>> firstMap, Map<String, List<int>> secondMap) {
  if (firstMap.length < secondMap.length) {
    Map<String, List<int>> temp = {};
    temp = firstMap;
    firstMap = secondMap;
    secondMap = temp;
  }

  for (String key in firstMap.keys) {
    if (secondMap.containsKey(key)) {
      List<int> temp = (mergeLists(firstMap[key], secondMap[key]));
      firstMap[key] = temp;
    }
  }

  for (String key in secondMap.keys) {
    if (!firstMap.containsKey(key)) {
      firstMap.addAll({key: secondMap[key]});
    }
  }
  return firstMap;
}

LinkedHashMap scoreCounter(Map<String, List<int>> values) {
  Map<String, int> result = {};
  for (String key in values.keys) {
    int counter = 0;
    for (int i = 0; i < 10; i++) {
      counter = counter + (3 - i) * values[key][i];
    }
    result.addAll({key: counter});
  }
  var sortedKeys = result.keys.toList(growable: false)
    ..sort((k1, k2) => result[k1].compareTo(result[k2]));
  LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => result[k]);

  return sortedMap;
}
