class Todo {
  final String id;
  final String text;
  final bool isCompleted;

  const Todo({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  Todo copyWith({
    String? id,
    String? text,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      text: json['text'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Todo &&
        other.id == id &&
        other.text == text &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => Object.hash(id, text, isCompleted);
}
