class Task {
  Task({
    required this.title,
    required this.id,
    required this.createdTime,
    required this.dueDate,
    this.description = '',
    this.completed = false,
    this.important = false,
    this.isBlocker = false,
    this.people = 'me',
    this.type = 'todo',
  });

  String title;
  int id;
  DateTime createdTime;
  DateTime dueDate;
  String description;
  bool completed;
  bool important;
  bool isBlocker;
  String people;
  String type;

  void toggleCompleted() {
    completed = !completed;
  }
}
