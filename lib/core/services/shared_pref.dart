import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> setName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', value);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? '';
  }

  static Future<void> setScore(String name) async {
    final prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(name) ?? 0;
    await prefs.setInt(name, value + 1);
  }

  static Future<int> getScore(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(name) ?? 0;
  }
}