import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class FlutterSecureStorageController {
  late final FlutterSecureStorage storage;
  late final IOSOptions iosOptions;

  FlutterSecureStorageController() {
    storage = const FlutterSecureStorage();
    iosOptions = getIOSOptions();
  }

  IOSOptions getIOSOptions() {
    return const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  }

  Future<void> setValue({required String key, required String value}) async {
    await storage.write(key: key, value: value, iOptions: iosOptions);
  }

  Future<String?> getValue({required String key}) async {
    return await storage.read(key: key, iOptions: iosOptions);
  }

  Future<void> deleteValue({required String key}) async {
    await storage.delete(key: key, iOptions: iosOptions);
  }
}
