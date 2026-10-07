import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();
  AuthService._internal();

  final ValueNotifier<UserProfile?> currentUser = ValueNotifier<UserProfile?>(null);
  String? _accessToken;

  static const String _keyToken = 'mythos_access_token';
  static const String _keyUser = 'mythos_user_profile';

  String get baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000/api/v1';
    }
    try {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:8000/api/v1';
      }
    } catch (_) {}
    return 'http://127.0.0.1:8000/api/v1';
  }

  bool get isAuthenticated => currentUser.value != null;

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _accessToken = prefs.getString(_keyToken);
      final userJson = prefs.getString(_keyUser);

      if (_accessToken != null && userJson != null) {
        final Map<String, dynamic> decoded = jsonDecode(userJson);
        currentUser.value = UserProfile.fromJson(decoded);
        // Silently refresh profile in the background
        refreshProfile().ignore();
      }
    } catch (e) {
      debugPrint('Error restoring auth session: $e');
    }
  }

  Future<AuthResponse> register({
    required String email,
    required String username,
    required String password,
    String? fullName,
    String patronDeity = 'Apollo',
  }) async {
    try {
      final url = Uri.parse('$baseUrl/auth/register');
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email.trim(),
              'username': username.trim(),
              'password': password,
              'full_name': fullName?.trim(),
              'patron_deity': patronDeity,
            }),
          )
          .timeout(const Duration(seconds: 8));

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        final token = data['access_token'] as String;
        final user = UserProfile.fromJson(data['user'] as Map<String, dynamic>);
        await _persistSession(token, user);
        return AuthResponse.success(user: user);
      } else {
        final detail = data['detail'] ?? 'Registration rejected by the temple.';
        return AuthResponse.error(detail.toString());
      }
    } catch (e) {
      return AuthResponse.error('Connection to Mount Olympus failed: $e');
    }
  }

  Future<AuthResponse> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/auth/login');
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email_or_username': emailOrUsername.trim(),
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 8));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = data['access_token'] as String;
        final user = UserProfile.fromJson(data['user'] as Map<String, dynamic>);
        await _persistSession(token, user);
        return AuthResponse.success(user: user);
      } else {
        final detail = data['detail'] ?? 'Invalid credentials.';
        return AuthResponse.error(detail.toString());
      }
    } catch (e) {
      return AuthResponse.error('Connection to Mount Olympus failed: $e');
    }
  }

  Future<void> refreshProfile() async {
    if (_accessToken == null) return;
    try {
      final url = Uri.parse('$baseUrl/auth/me');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_accessToken',
        },
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final user = UserProfile.fromJson(jsonDecode(response.body));
        currentUser.value = user;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_keyUser, jsonEncode(user.toJson()));
      }
    } catch (_) {}
  }

  Future<bool> updateProfile({String? fullName, String? patronDeity}) async {
    if (_accessToken == null) return false;
    try {
      final url = Uri.parse('$baseUrl/auth/profile');
      final body = <String, dynamic>{};
      if (fullName != null) body['full_name'] = fullName;
      if (patronDeity != null) body['patron_deity'] = patronDeity;

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_accessToken',
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final user = UserProfile.fromJson(jsonDecode(response.body));
        currentUser.value = user;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_keyUser, jsonEncode(user.toJson()));
        return true;
      }
    } catch (e) {
      debugPrint('Error updating profile: $e');
    }
    return false;
  }

  Future<void> awardExperience(int xp) async {
    if (_accessToken == null) {
      // Local fallback for guest
      if (currentUser.value != null) {
        final u = currentUser.value!;
        currentUser.value = UserProfile(
          id: u.id,
          email: u.email,
          username: u.username,
          fullName: u.fullName,
          patronDeity: u.patronDeity,
          mythicTitle: u.mythicTitle,
          experiencePoints: u.experiencePoints + xp,
          streakDays: u.streakDays,
        );
      }
      return;
    }
    try {
      final url = Uri.parse('$baseUrl/auth/experience');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_accessToken',
        },
        body: jsonEncode({'xp_to_add': xp}),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final user = UserProfile.fromJson(jsonDecode(response.body));
        currentUser.value = user;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_keyUser, jsonEncode(user.toJson()));
      }
    } catch (_) {}
  }

  Future<void> logout() async {
    _accessToken = null;
    currentUser.value = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyUser);
  }

  Future<void> _persistSession(String token, UserProfile user) async {
    _accessToken = token;
    currentUser.value = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }
}

class AuthResponse {
  final bool isSuccess;
  final String? errorMessage;
  final UserProfile? user;

  AuthResponse._({
    required this.isSuccess,
    this.errorMessage,
    this.user,
  });

  factory AuthResponse.success({required UserProfile user}) =>
      AuthResponse._(isSuccess: true, user: user);

  factory AuthResponse.error(String message) =>
      AuthResponse._(isSuccess: false, errorMessage: message);
}
