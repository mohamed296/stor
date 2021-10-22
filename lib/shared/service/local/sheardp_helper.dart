import 'package:shared_preferences/shared_preferences.dart';

class SherdHelper {
  static SharedPreferences? sP;
  static init() async {
    sP = await SharedPreferences.getInstance();
  }

  static dynamic getDataFromSP({required String key}) {
    return sP!.get(key);
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) return await sP!.setString(key, value);
    if (value is int) return await sP!.setInt(key, value);
    if (value is bool) return await sP!.setBool(key, value);
    return await sP!.setDouble(key, value);
  }

  static Future<dynamic> removData({required String key}) async {
    return await sP!.remove(key);
  }
}
