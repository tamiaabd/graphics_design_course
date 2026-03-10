import 'package:flutter/material.dart';
import '../models/course_data.dart';
import '../screens/lesson_detail_screen.dart';
import '../widgets/progress_indicator_widget.dart';

class ModulesScreen extends StatefulWidget {
  const ModulesScreen({super.key});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen> {
  bool _contentReady = false;

  @override
  void initState() {
    super.initState();
    // Defer heavy list layout to the next frame so navigation feels instant.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _contentReady = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Course Modules',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _contentReady ? _buildBody() : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6366F1),
            Colors.white,
          ],
          stops: [0.0, 0.15],
        ),
      ),
      child: const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6366F1),
            Colors.white,
          ],
          stops: [0.0, 0.15],
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: graphicDesignCourse.modules.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) return const ProgressIndicatorWidget();
          if (index == 1) return const SizedBox(height: 24);
          final module = graphicDesignCourse.modules[index - 2];
          return _buildModuleCard(context, module);
        },
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, Module module) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: module.color.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonDetailScreen(module: module),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Module Number Badge
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: module.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        module.icon,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        '${module.number}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: module.color,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Module Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MODULE ${module.number}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: module.color,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        module.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.menu_book,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${module.lessons.length} ${module.lessons.length == 1 ? 'Lesson' : 'Lessons'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: module.color,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
