import 'package:shared_preferences/shared_preferences.dart';

class UserInformation {
  static const _tokenKey = 'auth_token';
  static const _name = 'name';
  static const _email= 'email';

  // Save token
  static Future<void> saveToken(String token, String name,String email)async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_name, name);
    await prefs.setString(_email, email);
  }

  /// Get token
  static Future<Map<String, dynamic>> getUserBasicInfo()async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "token": prefs.getString(_tokenKey),
      "name" : prefs.getString(_name),
      "email": prefs.getString(_email),
    };
  }



  /// Remove token
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
