import 'package:form_field_validator/form_field_validator.dart';
	
final nameValidator = MultiValidator([
  RequiredValidator(errorText: "名前を入力してください"),
  MaxLengthValidator(20, errorText: "名前は20文字以下で入力してください"),
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: "メールアドレスを入力してください"),
  EmailValidator(errorText: "メールアドレスの形式が正しくありません"),
]);

class passwordRegValidator extends TextFieldValidator {
  passwordRegValidator({required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    if (value == null) {
      return false;
    }
    if (value.length < 8) {
      return false;
    }

    return RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$").hasMatch(value);
  }
}

final passwordValidator = MultiValidator([
  passwordRegValidator(errorText: "パスワードは8文字以上で、大文字、小文字、数字を含めてください"),
]);

// passwordが一致してるかどうかのバリデーション
class passwordMatchValidator extends TextFieldValidator {
  final String password;
  passwordMatchValidator({required this.password, required String errorText}) : super(errorText);

  bool isValid(String? value) {
    if (value == null) {
      return false;
    }
    return value == password;
  }

  String? validate(String? value) {
    if (isValid(value)) {
      return null;
    } else {
      return errorText;
    }
  }
}
