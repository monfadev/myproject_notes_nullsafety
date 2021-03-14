class MyNotes {
  int idModels;
  String titleModels;
  String bodyModels;
  String createDateModels;

  //Constructor
  MyNotes(
      {this.idModels,
      this.titleModels,
      this.bodyModels,
      this.createDateModels});

  //getter
  int get id => idModels;
  String get title => titleModels; // I mean get title is a create key database
  String get body => bodyModels;
  String get date => createDateModels;

  // Extract a Note object from a Map object
  MyNotes.map(dynamic object) {
    this.idModels = object['id'];
    this.titleModels = object['title'];
    this.bodyModels = object['body'];
    this.createDateModels = object['date'];
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = idModels;
    map['title'] = titleModels;
    map['body'] = bodyModels;
    map['date'] = createDateModels;
    return map;
  }

  void setNotesId(int id) {
    this.idModels = id;
  }

  //Setter
  set date(String newDate) {
    this.createDateModels = newDate;
  }

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this.titleModels = newTitle;
    }
  }

  set body(String newDescription) {
    if (newDescription.length <= 999) {
      this.bodyModels = newDescription;
    }
  }
}
