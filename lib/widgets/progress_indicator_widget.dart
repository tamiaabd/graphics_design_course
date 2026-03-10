import 'package:flutter/material.dart';
import '../models/course_data.dart';
import '../services/lesson_progress_service.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = LessonProgressService.instance.progress;
    final totalLessons = graphicDesignCourse.totalLessons;
    final completedLessons =
        progress.values.where((completed) => completed).length;
    final ratio =
        totalLessons == 0 ? 0.0 : completedLessons / totalLessons.toDouble();
    final percentText = '${(ratio * 100).round()}%';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Course Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              Text(
                percentText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: ratio,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color(0xFF6366F1),
            ),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat('${graphicDesignCourse.totalModules}', 'Modules'),
              _buildStat('${graphicDesignCourse.totalLessons}', 'Lessons'),
              _buildStat(graphicDesignCourse.duration, 'Duration'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6366F1),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
