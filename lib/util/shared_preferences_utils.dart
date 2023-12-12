import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static const String keyUserId = 'KEY_USER_ID';
  static const String keySignInMethod = 'KEY_SIGN_IN_METHOD';

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUserId);
  }

  static Future<void> setUserId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUserId, id);
  }

  static Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyUserId);
  }

  static Future<String?> getSignInEmthod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keySignInMethod);
  }

  static Future<void> setSignInEmthod(String signInMethod) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keySignInMethod, signInMethod);
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
