import 'dart:collection';
import 'dart:convert';

import 'Poem.dart';

class PoemStorage {
  final List<Poem> poems;

  PoemStorage(this.poems);

  factory PoemStorage.fromJson(var rawJson) {
    Map<String, dynamic> map = jsonDecode(rawJson);
    List<dynamic> list =  map['poems'];
    List<Poem> poems = [];
    for(Map<String, dynamic> p in list) {
      String title = p['title'];
      String poem = p['poem'];
      poems.add(Poem(title, poem));
    }
    return PoemStorage(poems);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = HashMap<String, dynamic>();
    result.putIfAbsent("poems", () => poems);

    return result;
  }

}