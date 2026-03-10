import 'package:flutter/material.dart';
import '../models/course_data.dart';
import '../screens/final_message_screen.dart';
import '../services/lesson_progress_service.dart';

class LessonDetailScreen extends StatefulWidget {
  final Module module;

  const LessonDetailScreen({super.key, required this.module});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  bool _contentReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await LessonProgressService.instance.loadAll();
      if (mounted) setState(() => _contentReady = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Module ${widget.module.number}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: widget.module.color,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _contentReady ? _buildBody() : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: widget.module.color,
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            widget.module.color,
            Colors.white,
          ],
          stops: const [0.0, 0.2],
        ),
      ),
      child: Column(
        children: [
          // Module Header
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    widget.module.icon,
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.module.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Lessons List
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: widget.module.lessons.length,
                      itemBuilder: (context, index) {
                        final lesson = widget.module.lessons[index];
                        return _buildLessonCard(context, lesson, index + 1);
                      },
                    ),
                  ),
                  // Show final message button if last module
                  if (widget.module.number == graphicDesignCourse.modules.length)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FinalMessageScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.module.color,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                          ),
                          child: const Text(
                            'View Final Message',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(BuildContext context, Lesson lesson, int lessonNumber) {
    final lessonKey = 'module_${widget.module.number}_lesson_$lessonNumber';
    final isCompleted = LessonProgressService.instance.isCompleted(lessonKey);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.module.color.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: GestureDetector(
            onTap: () async {
              // Only admin should toggle; student will be wired later via role.
              await LessonProgressService.instance.toggle(lessonKey);
              if (mounted) {
                setState(() {});
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted
                    ? widget.module.color
                    : widget.module.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$lessonNumber',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.white : widget.module.color,
                  ),
                ),
              ),
            ),
          ),
        title: Text(
          lesson.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF1F2937),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Content
                Text(
                  lesson.content,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF4B5563),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Bullet Points
                if (lesson.bulletPoints != null && lesson.bulletPoints!.isNotEmpty) ...[
                  const Divider(),
                  const SizedBox(height: 12),
                  ...lesson.bulletPoints!.map((point) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6, right: 12),
                          width: 6,
                          height: 6,
                        decoration: BoxDecoration(
                          color: widget.module.color,
                          shape: BoxShape.circle,
                        ),
                        ),
                        Expanded(
                          child: Text(
                            point,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF4B5563),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
                
                // Examples
                if (lesson.examples != null && lesson.examples!.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: widget.module.color.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Examples:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: widget.module.color,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: lesson.examples!.map((example) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: widget.module.color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                example,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: widget.module.color,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}
