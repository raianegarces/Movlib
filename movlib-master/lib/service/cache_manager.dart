import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static const _userId = 'userId';

  static Future<String> getUserId() async{
    final prefs = await SharedPreferences.getInstance();

    String id = prefs.getString(_userId);

    return id;
  }

  static Future<void> setUserId(String id) async{
    print('seting user id: $id');
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(_userId, id);
  }
}