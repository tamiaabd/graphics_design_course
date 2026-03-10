import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton service that tracks lesson completion locally.
/// Extends [ChangeNotifier] so any widget can listen and rebuild when
/// progress changes (e.g. the progress bar updates instantly on toggle).
class LessonProgressService extends ChangeNotifier {
  LessonProgressService._();

  static final LessonProgressService instance = LessonProgressService._();

  final Map<String, bool> _progress = {};

  Map<String, bool> get progress => Map.unmodifiable(_progress);

  double get ratio {
    if (_progress.isEmpty) return 0.0;
    final completed = _progress.values.where((v) => v).length;
    return completed / _progress.length;
  }

  bool isCompleted(String lessonKey) => _progress[lessonKey] ?? false;

  /// Load persisted progress from SharedPreferences on app start.
  Future<void> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('cached_lesson_progress');
    if (cached != null) {
      try {
        final map = jsonDecode(cached) as Map<String, dynamic>;
        _progress
          ..clear()
          ..addEntries(
            map.entries.map((e) => MapEntry(e.key, e.value as bool)),
          );
        notifyListeners();
      } catch (_) {
        // Corrupt cache — start fresh.
      }
    }
  }

  /// Toggle a lesson's completion and persist locally.
  Future<void> toggle(String lessonKey) async {
    _progress[lessonKey] = !isCompleted(lessonKey);
    notifyListeners(); // ← triggers instant UI rebuild everywhere

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_lesson_progress', jsonEncode(_progress));
  }
}
