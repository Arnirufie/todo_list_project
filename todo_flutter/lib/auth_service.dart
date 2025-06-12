import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const baseUrl = 'http://192.168.18.37:8000/api';

  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      return true;
    } else {
      print('Login gagal: ${response.statusCode}');
      print(response.body);
      return false;
    }
  }

  static Future<bool> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode({'name': name, 'email': email, 'password': password}),
    );

    print('Register status: ${response.statusCode}');
    print('Register response: ${response.body}');

    return response.statusCode == 201 || response.statusCode == 200;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  // Fungsi tambahan untuk mengambil token dari SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Contoh fungsi request authorized dengan token di header
  static Future<List<dynamic>?> fetchTasks() async {
    final token = await getToken();
    if (token == null) {
      print('Token tidak ditemukan, user belum login');
      return null;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/tasks'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      print('Fetch tasks gagal: ${response.statusCode}');
      print(response.body);
      return null;
    }
  }
}
