import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/logged_in_user.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:5206/api/auth';

  Future<LoggedInUser> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    final resp = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'content-type': 'application/json'},
      body: body,
    );

    if (resp.statusCode == 201) {
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      final user = LoggedInUser.fromJson(json);
      await _saveUser(user);
      return user;
    } else {
      throw Exception('Register failed: ${resp.body}');
    }
  }

  Future<LoggedInUser> login({
    required String email,
    required String password,
  }) async {
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    final resp = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      final user = LoggedInUser.fromJson(json);
      await _saveUser(user);
      return user;
    } else {
      throw Exception('Login Failed: ${resp.body}');
    }
  }

  Future<void> _saveUser(LoggedInUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(user.toJson()));
  }

Future<LoggedInUser?> getCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonStr = prefs.getString('user');
  if (jsonStr == null) return null;

  final map = jsonDecode(jsonStr) as Map<String, dynamic>;
  return LoggedInUser.fromJson(map);
}

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
