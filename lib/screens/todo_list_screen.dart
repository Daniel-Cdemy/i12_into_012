import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/providers/app_state_provider.dart';
import 'package:i12_into_012/screens/settings_screen.dart';
import 'package:i12_into_012/widgets/add_todo_dialog.dart';
import 'package:i12_into_012/widgets/todo_item.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  Future<void> _addTodo(BuildContext context, WidgetRef ref) async {
    final text = await showDialog<String?>(
      context: context,
      builder: (_) => const AddTodoDialog(),
    );

    if (text != null && text.trim().isNotEmpty) {
      ref.read(appStateProvider.notifier).addTodo(text);
    }
  }

  Future<void> _deleteSelected(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(appStateProvider.notifier);
    final asks = ref.read(asksForDeletionConfirmationProvider);

    if (asks) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
            'Are you sure you want to delete the selected items?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirm != true) return;
    }

    await notifier.deleteSelectedTodos();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    final selectedIds = ref.watch(selectedTodosProvider);
    final hasSelection = ref.watch(hasSelectedTodosProvider);

    return Scaffold(
      appBar: AppBar(
        title: hasSelection
            ? Text('${selectedIds.length} selected')
            : const Text('Todos'),
        actions: [
          if (hasSelection)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteSelected(context, ref),
            ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: todos.isEmpty
          ? const Center(child: Text('No todos yet. Tap + to add one.'))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                final isSelected = selectedIds.contains(todo.id);

                return Padding(
                  key: ValueKey(todo.id),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: TodoItem(
                    todo: todo,
                    isSelected: isSelected,
                    onToggleComplete: () {
                      ref.read(appStateProvider.notifier).toggleTodo(todo.id);
                    },
                    onLongPress: () {
                      ref
                          .read(appStateProvider.notifier)
                          .toggleSelection(todo.id);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodo(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
