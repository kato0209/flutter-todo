import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/todo_list.dart';
import '../features/validators/portal_validator.dart';
import '../providers/api_client_providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../providers/flutter_secure_storage_provider.dart';
import 'portal.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    const formKey = GlobalObjectKey<FormState>('FORM_KEY');
    const emailKey = GlobalObjectKey<FormFieldState>('EMAIL_KEY');
    const passwordKey = GlobalObjectKey<FormFieldState>('PASSWORD_KEY');

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  key: emailKey,
                  validator: emailValidator,
                  decoration: const InputDecoration(
                  labelText: 'メールアドレスを入力してください',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  key: passwordKey,
                  validator: passwordValidator,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      icon: Icon(_isObscure
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      })),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async{
                    if (formKey.currentState!.validate()) {
                      var apiclient = ApiClient(baseUrl: dotenv.get('API_URL'), accesToken: '');
                      var res = await apiclient.post(
                        '/api/login',
                        body: {
                          'email': emailKey.currentState!.value,
                          'password': passwordKey.currentState!.value,
                        }
                      );
                      if (res.statusCode == 200) {
                        String jwtToken = json.decode(res.body)['jwtToken'];
                        var storageController = FlutterSecureStorageController();
                        await storageController.setValue(key: 'jwtToken', value: jwtToken);
                        // Widgetをリロードする
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return const ToDoListPage();
                          }),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ログインに失敗しました'))
                        );
                      }
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.greenAccent)
                    ),
                    child: const Text('ログイン', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
          )
        ),
      ),
    );
  }
}
