import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setBool({required String key, required bool value}) {
    return sharedPreferences.setBool(key, value);
  }

  static Future<bool> setString({required String key, required String value}) {
    return sharedPreferences.setString(key, value);
  }

  static getBool({required String key}) {
    return sharedPreferences.get(key);
  }

  static getString({required String key}) {
    return sharedPreferences.get(key);
  }
}
