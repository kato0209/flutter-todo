import 'package:flutter/material.dart';
import 'package:flutter_todo/features/validators/portal_validator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isObscure = true;
  bool _isObscure2 = true;
  String password = '';

  @override
  Widget build(BuildContext context) {
    const formKey = GlobalObjectKey<FormState>('FORM_KEY');

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
                  validator: emailValidator,
                  decoration: const InputDecoration(
                  labelText: 'メールアドレスを入力してください',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  validator: nameValidator,
                  decoration: const InputDecoration(
                  labelText: 'ユーザー名を入力してください',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        validator: passwordValidator,
                        obscureText: _isObscure,
                        onChanged: (value) => password = value,
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
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        validator: (value) {
                          return passwordMatchValidator(password: password, errorText: 'パスワードが一致しません').validate(value);
                        },
                        obscureText: _isObscure2,
                        decoration: InputDecoration(
                        labelText: 'Password再入力',
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure2
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure2 = !_isObscure2;
                              });
                            })),
                      ),
                    ),
                  )
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    if (formKey.currentState!.validate()) {
                    }
                  },
                  child: Text('サインアップ', style: TextStyle(color: Colors.black)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.greenAccent)),
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
