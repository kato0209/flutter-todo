import 'package:flutter/material.dart';
import '../features/todo/todo_item.dart';
import '../features/todo/todo_add.dart';
import '../providers/api_client_providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../providers/flutter_secure_storage_provider.dart';
import 'dart:convert';
import '../models/todo.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Todo> todoList = [];

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    var storageController = FlutterSecureStorageController();
    String? jwtToken = await storageController.getValue(key: 'jwtToken');
    var apiclient = ApiClient(baseUrl: dotenv.get('API_URL'), accesToken: jwtToken!);
    var res = await apiclient.get(
      '/api/todos',
    );
    if (res.statusCode == 200) {
      List<dynamic> todos = json.decode(res.body);
      List<Todo> todoList = [];
      for (var t in todos) {
        Todo todo = new Todo(
          id: t['todoID'],
          userID: t['userID'],
          content: t['content'],
          createdAt: DateTime.parse(t['createdAt']['date']),
        );
        todoList.add(todo);
      }
      setState(() {
        this.todoList = todoList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('リスト一覧'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ToDoItem(
              item: todoList[index],
              onDelete: () {
                setState(() {
                  todoList.removeAt(index);
                });
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Todo? todo = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const ToDoAddPage();
            }),
          );
          if (todo != null) {
            setState(() {
              todoList.add(todo);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
