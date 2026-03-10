import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course_data.dart';
import '../models/app_user.dart';
import '../screens/modules_screen.dart';
import '../screens/login_screen.dart';
import '../widgets/course_infographic.dart';
import '../widgets/responsive_constraint.dart';

class HomeScreen extends StatefulWidget {
  final AppUser? currentUser;

  const HomeScreen({super.key, this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _studentEmails = [];

  @override
  void initState() {
    super.initState();
    if (widget.currentUser?.isAdmin == true) {
      _loadStudents();
    }
  }

  Future<void> _loadStudents() async {
    // Load from cache first for instant display.
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getStringList('cached_student_emails');
    if (cached != null && cached.isNotEmpty) {
      setState(() => _studentEmails = cached);
    }

    // Then try to fetch fresh data from Supabase.
    try {
      final rows = await Supabase.instance.client
          .from('profiles')
          .select('email')
          .eq('role', 'student');
      final fresh = rows
          .map<String>((r) => (r['email'] as String?) ?? '')
          .where((e) => e.isNotEmpty)
          .toList();
      setState(() => _studentEmails = fresh);
      await prefs.setStringList('cached_student_emails', fresh);
    } catch (_) {
      // Offline — keep showing cached data.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.currentUser?.isAdmin == true
          ? FloatingActionButton(
              onPressed: () {
                _showAddStudentDialog(context);
              },
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF6366F1),
              child: const Icon(Icons.add),
            )
          : null,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFEC4899)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ResponsiveConstraint(
              maxWidth: 1080,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand name
                    Center(
                      child: Text(
                        'Soft Tech Hub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width < 400
                              ? 36
                              : 50,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'GRAPHIC DESIGN',
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.3,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                      ? 22
                                      : 28,
                                ),
                              ),
                              Text(
                                'COMPLETE COURSE',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w300,
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                      ? 16
                                      : 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${graphicDesignCourse.totalModules} Modules',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            widget.currentUser == null
                                ? TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (_) => const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                    tooltip: 'Logout',
                                    onPressed: () => _logout(context),
                                  ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Duration: ${graphicDesignCourse.duration}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Course Description Card
                    Container(
                      width: double.infinity,
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
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF6366F1,
                                  ).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.palette,
                                  color: Color(0xFF6366F1),
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Welcome to the Graphic Design Master Course',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF1F2937),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            graphicDesignCourse.description,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: const Color(0xFF6B7280),
                                  height: 1.6,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Learning Outcomes
                    Text(
                      'What You Will Learn',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Container(
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
                        children: graphicDesignCourse.learningOutcomes.map((
                          outcome,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF6366F1),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    outcome,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: const Color(0xFF1F2937),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Course Path Infographic
                    Text(
                      'Course Path',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Container(
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
                      child: SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 16,
                          children: [
                            _buildPathStep(
                              'Beginner',
                              Icons.rocket_launch,
                              Colors.green,
                            ),
                            Container(
                              width: 32,
                              height: 2,
                              color: const Color(0xFF6366F1),
                            ),
                            _buildPathStep(
                              'Professional',
                              Icons.workspace_premium,
                              Colors.blue,
                            ),
                            Container(
                              width: 32,
                              height: 2,
                              color: const Color(0xFF6366F1),
                            ),
                            _buildPathStep(
                              'Advanced',
                              Icons.stars,
                              Colors.purple,
                            ),
                          ],
                        ), // Wrap
                      ), // SizedBox
                    ),
                    const SizedBox(height: 24),

                    // Course Structure Infographic
                    const CourseInfographic(),
                    const SizedBox(height: 32),

                    // CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.currentUser == null) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: const Text(
                                  'Login Needed',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  'Please contact us to create an account:\n\n📞 Tamia: 03157401330',
                                  style: TextStyle(fontSize: 15, height: 1.6),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ModulesScreen(),
                              ),
                            );
                          }
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
                          'Start Learning',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Students Section (admin only)
                    if (widget.currentUser?.isAdmin == true) ...[
                      Text(
                        'Students',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
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
                        child: _studentEmails.isEmpty
                            ? const Text(
                                'No students added yet. Use the + button to add one.',
                                style: TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 14,
                                ),
                              )
                            : Column(
                                children: _studentEmails.map((email) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xFF6366F1,
                                            ).withValues(alpha: 0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: Color(0xFF6366F1),
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            email,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF1F2937),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.phonelink_erase,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                          tooltip: 'Reset device',
                                          onPressed: () async {
                                            await Supabase.instance.client
                                                .from('profiles')
                                                .update({'device_id': null})
                                                .eq('email', email);
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Device reset successfully.',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                      // const SizedBox(height: 24),
                    ],
                  ],
                ),
              ), // Padding
            ), // ResponsiveConstraint
          ),
        ),
      ),
    );
  }

  Widget _buildPathStep(String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }

  void _showAddStudentDialog(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool isLoading = false;
    String? errorMsg;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text(
                'Add Student',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Student email',
                      hintText: 'student@example.com',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Min 6 characters',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (errorMsg != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      errorMsg!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final email = emailController.text.trim();
                          final password = passwordController.text;

                          if (email.isEmpty || !email.contains('@')) {
                            setDialogState(
                              () => errorMsg = 'Enter a valid email.',
                            );
                            return;
                          }
                          if (password.length < 6) {
                            setDialogState(
                              () => errorMsg =
                                  'Password must be at least 6 characters.',
                            );
                            return;
                          }

                          setDialogState(() {
                            isLoading = true;
                            errorMsg = null;
                          });

                          try {
                            // Sign up the student (creates account in Supabase Auth)
                            final res = await Supabase.instance.client.auth
                                .signUp(email: email, password: password);

                            final uid = res.user?.id;
                            if (uid == null) {
                              setDialogState(() {
                                isLoading = false;
                                errorMsg = 'Could not create account.';
                              });
                              return;
                            }

                            // Insert into profiles with role=student and email
                            await Supabase.instance.client
                                .from('profiles')
                                .upsert({
                                  'id': uid,
                                  'role': 'student',
                                  'email': email,
                                });

                            if (context.mounted) Navigator.of(context).pop();

                            // Refresh student list
                            _loadStudents();
                          } catch (e) {
                            setDialogState(() {
                              isLoading = false;
                              errorMsg = e.toString();
                            });
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    // Clear all cached data on logout.
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cached_user_id');
    await prefs.remove('cached_user_email');
    await prefs.remove('cached_user_role');
    await prefs.remove('cached_student_emails');
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }
}
