import 'package:flutter/material.dart';
import '../../models/todo.dart';

class ToDoItem extends StatelessWidget {
  final Todo item;
  final VoidCallback onDelete;

  const ToDoItem({super.key, required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.content),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
