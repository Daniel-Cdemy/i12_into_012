import 'package:flutter/material.dart';

import 'package:i12_into_012/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final bool isSelected;
  final VoidCallback onToggleComplete;
  final VoidCallback onLongPress;

  const TodoItem({
    super.key,
    required this.todo,
    required this.isSelected,
    required this.onToggleComplete,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (_) => onToggleComplete(),
      ),
      title: Text(
        todo.text,
        style: TextStyle(
          decoration: todo.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle)
          : const SizedBox.shrink(),
      onTap: onToggleComplete,
      onLongPress: onLongPress,
    );
  }
}
