class Note {
  int? id;
  String? title;
  String? description;
  String? noteColor;

  Note(
      {this.id = null,
      this.title = "Title",
      this.description = "Description",
      this.noteColor = 'red'});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) {
      data['id'] = id;
    }
    data['title'] = title;
    data['description'] = description;
    data['noteColor'] = noteColor;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return {
      'id': id,
      'title': title,
      'description': description,
      'noteColor': noteColor,
    }.toString();
  }
}
