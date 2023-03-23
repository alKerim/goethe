class Poem {
  final String title;
  final String poem;

  Poem(this.title, this.poem);

  factory Poem.fromJson(Map<String, dynamic> map) {
    String title = map['title'];
    String poem = map['poem'];

    return Poem(title, poem);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'poem': poem,
    };
  }

  @override
  String toString() {
    return "$title\n$poem";
  }
}
