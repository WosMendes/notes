class Note {
  int? id;
  String title;
  String body;
  String time;

  Note({
    this.id,
    required this.title,
    required this.body,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "time": time,
    });
  }
}
