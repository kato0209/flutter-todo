import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';

class PortalPage extends StatelessWidget {
  const PortalPage({super.key});

  @override
  Widget build(BuildContext context) {
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
