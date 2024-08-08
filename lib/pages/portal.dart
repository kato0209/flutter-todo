import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';
import 'todo_list.dart';
import '../providers/flutter_secure_storage_provider.dart';

class PortalPage extends StatefulWidget {
  const PortalPage({super.key});

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  String? jwtToken;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    var storageController = FlutterSecureStorageController();
    jwtToken = await storageController.getValue(key: 'jwtToken');
    setState(() {
      jwtToken = jwtToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (jwtToken != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Portalページ'),
        ),
        body: const Center(
          child: ToDoListPage()
        ),
      );
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Portalページ'),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TabBar(tabs: [
                Tab(text: 'Signup',),
                Tab(text: 'Login',),
              ],),
              Expanded(
                child: TabBarView(
                children: [
                  SignupPage(),
                  LoginPage(),
                ],
              ),
            )
            ]
          )
        )
      ),
    );
  }
}
