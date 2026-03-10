import 'package:flutter/material.dart';
import '../models/course_data.dart';

class CourseInfographic extends StatelessWidget {
  const CourseInfographic({super.key});

  @override
  Widget build(BuildContext context) {
    final moduleByNumber = {
      for (final m in graphicDesignCourse.modules) m.number: m,
    };
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Course Structure',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 24),
          
          // Module Categories Visualization
          _buildCategorySection(
            moduleByNumber,
            'Foundation',
            [1, 2, 3, 4],
            const Color(0xFF10B981),
          ),
          const SizedBox(height: 16),
          _buildCategorySection(
            moduleByNumber,
            'Core Skills',
            [5, 6, 7, 8, 9, 10],
            const Color(0xFF6366F1),
          ),
          const SizedBox(height: 16),
          _buildCategorySection(
            moduleByNumber,
            'Professional',
            [11, 12, 13, 14, 15],
            const Color(0xFFEC4899),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(
    Map<int, Module> moduleByNumber,
    String title,
    List<int> moduleNumbers,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: moduleNumbers.map((moduleNum) {
            final module = moduleByNumber[moduleNum]!;
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    module.icon,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'M$moduleNum',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
