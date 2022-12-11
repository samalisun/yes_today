class Todo {
  Todo({
    required this.title,
    required this.id,
    this.description = '',
    this.completed = false,
  });

  String title;
  int id;
  String description;
  bool completed;

  void toggleCompleted() {
    completed = !completed;
  }
}