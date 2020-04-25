import 'results.dart';

void main() {
  Map<String, List<int>> temp1 = placeCounter(random_24_04);
  Map<String, List<int>> temp2 = placeCounter(random_23_04);
  Map<String, List<int>> merged = mergeMaps(temp1, temp2);

  for (String key in merged.keys) {
    print("$key :" + " ${merged[key]}");
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
