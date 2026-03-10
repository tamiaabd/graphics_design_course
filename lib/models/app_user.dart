class AppUser {
  final String id;
  final String email;
  final String role; // 'admin' or 'student'

  const AppUser({
    required this.id,
    required this.email,
    required this.role,
  });

  bool get isAdmin => role == 'admin';
}

