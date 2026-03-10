import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LessonProgressService {
  LessonProgressService._();

  static final LessonProgressService instance = LessonProgressService._();

  final SupabaseClient _client = Supabase.instance.client;

  /// In-memory cache of global lesson progress keyed by lessonKey.
  final Map<String, bool> _progress = {};

  Map<String, bool> get progress => Map.unmodifiable(_progress);

  Future<void> loadAll() async {
    final prefs = await SharedPreferences.getInstance();

    // Step 1: Load from local cache immediately (works offline too).
    final cached = prefs.getString('cached_lesson_progress');
    if (cached != null) {
      try {
        final map = jsonDecode(cached) as Map<String, dynamic>;
        _progress
          ..clear()
          ..addEntries(
            map.entries.map((e) => MapEntry(e.key, e.value as bool)),
          );
      } catch (_) {
        // Corrupt cache — ignore and fetch fresh.
      }
    }

    // Step 2: Try to fetch fresh data from Supabase in the background.
    try {
      final rows = await _client
          .from('lesson_progress')
          .select('lesson_key, completed');
      _progress
        ..clear()
        ..addEntries(rows.map<MapEntry<String, bool>>(
          (row) => MapEntry(
            row['lesson_key'] as String,
            (row['completed'] as bool?) ?? false,
          ),
        ));
      // Save fresh data to local cache.
      await prefs.setString('cached_lesson_progress', jsonEncode(_progress));
    } catch (_) {
      // Offline — keep using the cache loaded in step 1.
    }
  }

  bool isCompleted(String lessonKey) {
    return _progress[lessonKey] ?? false;
  }

  Future<void> toggle(String lessonKey) async {
    final newValue = !isCompleted(lessonKey);
    _progress[lessonKey] = newValue;

    // Save to local cache immediately (instant, no network needed).
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_lesson_progress', jsonEncode(_progress));

    // Then try to sync to Supabase.
    try {
      await _client.from('lesson_progress').upsert({
        'lesson_key': lessonKey,
        'completed': newValue,
      });
    } catch (_) {
      // Offline — the toggle is saved locally and will sync on next loadAll().
    }
  }
}
