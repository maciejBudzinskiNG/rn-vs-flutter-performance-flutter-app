import 'dart:math';

List shuffle(List list) {
  for (int i = list.length - 1; i > 0; i--) {
    var j = new Random().nextInt(i + 1);
    var temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }
  return list;
}

List sort(List list) {
  list.sort((a, b) => a['id'].compareTo(b['id']));
  return list;
}
