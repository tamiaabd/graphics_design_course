import 'package:flutter/material.dart';
import '../models/course_data.dart';

class FinalMessageScreen extends StatelessWidget {
  const FinalMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF6366F1),
              const Color(0xFF8B5CF6),
              const Color(0xFFEC4899),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Success Icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.celebration,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Title
                const Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                
                // Final Message Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        graphicDesignCourse.finalMessage,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF1F2937),
                          height: 1.8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      
                      // Key Takeaways
                      _buildTakeaway(
                        Icons.lightbulb,
                        'Study Good Designs',
                        'Analyze successful designs to understand what works',
                      ),
                      const SizedBox(height: 16),
                      _buildTakeaway(
                        Icons.repeat,
                        'Practice Regularly',
                        'Consistent practice builds your skills',
                      ),
                      const SizedBox(height: 16),
                      _buildTakeaway(
                        Icons.folder_special,
                        'Build Your Portfolio',
                        'Showcase your best work to potential clients',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Stats Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        '${graphicDesignCourse.totalModules}',
                        'Modules',
                        Icons.book,
                        const Color(0xFF6366F1),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        '${graphicDesignCourse.totalLessons}',
                        'Lessons',
                        Icons.menu_book,
                        const Color(0xFF8B5CF6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        graphicDesignCourse.duration,
                        'Duration',
                        Icons.schedule,
                        const Color(0xFFEC4899),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        '100%',
                        'Complete',
                        Icons.check_circle,
                        const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                // Action Buttons
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6366F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 18,
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
    );
  }

  Widget _buildTakeaway(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF6366F1)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
