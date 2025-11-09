// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

/////////////////////////////////////////////////////////////////////////////////////////////////////////
class SharedProf {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> savadata({
    required String key,
    required dynamic value,
  }) async {
    if (_prefs == null) {
      // SharedPreferences not initialized
      return false; // لو مش متهيئة، رجع false
    }

    if (value is String) return _prefs!.setString(key, value);
    if (value is int) return _prefs!.setInt(key, value);
    if (value is bool) return _prefs!.setBool(key, value);
    if (value is double) return _prefs!.setDouble(key, value);
    if (value is Set<String>) return _prefs!.setStringList(key, value.toList());
    throw Exception("Type not supported");
  }

  static dynamic getData({required String key}) {
    return _prefs!.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return _prefs!.remove(key);
  }

  static Future<Set<String>> loadFavorites({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    return list.toSet();
  }
}
