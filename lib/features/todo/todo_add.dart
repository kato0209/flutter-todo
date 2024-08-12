import 'package:flutter/material.dart';
import '../../providers/api_client_providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../providers/flutter_secure_storage_provider.dart';
import 'dart:convert';
import '../../models/todo.dart';

class ToDoAddPage extends StatefulWidget {
  final int userID;
  const ToDoAddPage({super.key, required this.userID});

  @override
  _ToDoAddPageState createState() => _ToDoAddPageState();
}

class _ToDoAddPageState extends State<ToDoAddPage> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('リスト追加'),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _text,
              style: TextStyle(color: Colors.black),
            ),
            TextField(
              onChanged: (String value) {
                setState(() {
                  _text = value;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.greenAccent)),
                onPressed: () async {
                  var storageController = FlutterSecureStorageController();
                  String? jwtToken = await storageController.getValue(key: 'jwtToken');
                  var apiclient = ApiClient(baseUrl: dotenv.get('API_URL'), accesToken: jwtToken!);
                  var res = await apiclient.post(
                    '/api/todos',
                    body: {
                      'userID': widget.userID,
                      'content': _text,
                    }
                  );
                  if (res.statusCode == 201) {
                    var todoJson = json.decode(res.body);
                    Todo todo = new Todo(
                      id: todoJson['todoID'],
                      userID: todoJson['userID'],
                      content: todoJson['content'],
                      createdAt: DateTime.parse(todoJson['createdAt']['date']),
                    );
                    Navigator.of(context).pop(todo);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('todo作成に失敗しました'))
                    );
                  }
                },
                child: Text(
                  'todoを追加',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: TextButton(
                child: Text(
                  'キャンセル',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
