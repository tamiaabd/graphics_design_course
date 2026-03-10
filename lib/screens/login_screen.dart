import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_user.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;
  bool _obscurePassword = true;

  SupabaseClient get _client => Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedId = prefs.getString('cached_user_id');
    final cachedEmail = prefs.getString('cached_user_email');
    final cachedRole = prefs.getString('cached_user_role');

    // If we have both a live session and cached user, navigate instantly.
    final session = _client.auth.currentSession;
    if (session != null && cachedId != null && cachedRole != null) {
      final appUser = AppUser(
        id: cachedId,
        email: cachedEmail ?? '',
        role: cachedRole,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomeScreen(currentUser: appUser),
        ),
      );
      return;
    }

    // Live session but no cache yet — fetch from Supabase.
    if (session != null) {
      _navigateToHome();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session == null || response.user == null) {
        setState(() {
          _error = 'Login failed. Please check your credentials.';
        });
        return;
      }

      await _navigateToHome();
    } on AuthException catch (e) {
      setState(() {
        _error = e.message;
      });
    } catch (_) {
      setState(() {
        _error = 'Unexpected error. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _navigateToHome() async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    final prefs = await SharedPreferences.getInstance();

    // Try to load role from Supabase; fall back to cached role if offline.
    String role = prefs.getString('cached_user_role') ?? 'student';
    try {
      final result = await _client
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .maybeSingle();
      if (result != null && result['role'] is String) {
        role = result['role'] as String;
      }
    } catch (_) {
      // Offline — use cached role.
    }

    // Cache user data for instant startup next time.
    await prefs.setString('cached_user_id', user.id);
    await prefs.setString('cached_user_email', user.email ?? '');
    await prefs.setString('cached_user_role', role);

    final appUser = AppUser(
      id: user.id,
      email: user.email ?? '',
      role: role,
    );

    // Skip device check for admin.
    if (role == 'student') {
      final deviceId = await _getDeviceId();
      try {
        final profile = await _client
            .from('profiles')
            .select('device_id')
            .eq('id', user.id)
            .maybeSingle();

        final savedDeviceId = profile?['device_id'] as String?;

        if (savedDeviceId != null && savedDeviceId != deviceId) {
          // Different device — block login.
          await _client.auth.signOut();
          await prefs.remove('cached_user_id');
          await prefs.remove('cached_user_email');
          await prefs.remove('cached_user_role');
          setState(() {
            _error = 'This account is already active on another device.';
            _isLoading = false;
          });
          return;
        }

        // First login or same device — save device ID.
        await _client
            .from('profiles')
            .update({'device_id': deviceId})
            .eq('id', user.id);
      } catch (_) {
        // Offline — allow if cached user matches.
      }
    }

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(currentUser: appUser),
      ),
    );
  }

  Future<String> _getDeviceId() async {
  final prefs = await SharedPreferences.getInstance();
  String? storedId = prefs.getString('device_id');
  if (storedId != null) return storedId;

  // Generate a new UUID for this device
  final deviceInfo = DeviceInfoPlugin();
  String rawId;
  if (Platform.isAndroid) {
    final info = await deviceInfo.androidInfo;
    rawId = info.id;
  } else if (Platform.isIOS) {
    final info = await deviceInfo.iosInfo;
    rawId = info.identifierForVendor ?? DateTime.now().toString();
  } else {
    rawId = DateTime.now().millisecondsSinceEpoch.toString();
  }

  await prefs.setString('device_id', rawId);
  return rawId;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6366F1),
              Color(0xFF8B5CF6),
              Color(0xFFEC4899),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Use your Supabase email and password.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        autofillHints: const [],
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      if (_error != null) ...[
                        Text(
                          _error!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(
                                  currentUser: null,
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF6366F1),
                            side: const BorderSide(color: Color(0xFF6366F1)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Continue Offline',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

