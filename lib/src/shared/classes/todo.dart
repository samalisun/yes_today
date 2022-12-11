class Todo {
  Todo({
    required this.title,
    this.completed = false,
  });

  String title;
  bool completed;

  void toggleCompleted() {
    completed = !completed;
  }
}