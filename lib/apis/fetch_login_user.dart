import '../models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../providers/flutter_secure_storage_provider.dart';
import '../../providers/api_client_providers.dart';
import 'dart:convert';

Future<User> fetchLoginUser() async {
  var storageController = FlutterSecureStorageController();
  String? jwtToken = await storageController.getValue(key: 'jwtToken');
  var apiclient = ApiClient(baseUrl: dotenv.get('API_URL'), accesToken: jwtToken!);
  var res = await apiclient.get(
    '/api/users'
  );
  if (res.statusCode == 200) {
    Map<String, dynamic> user = json.decode(res.body);
    return User(
      id: user['id'],
      name: user['name'],
      email: user['email'],
    );
  } else {
    throw Exception('Failed to load user');
  }
}
  