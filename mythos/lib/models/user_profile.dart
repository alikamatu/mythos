class UserProfile {
  final String id;
  final String email;
  final String username;
  final String? fullName;
  final String patronDeity;
  final String mythicTitle;
  final int experiencePoints;
  final int streakDays;

  const UserProfile({
    required this.id,
    required this.email,
    required this.username,
    this.fullName,
    required this.patronDeity,
    required this.mythicTitle,
    required this.experiencePoints,
    required this.streakDays,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      username: json['username'] as String? ?? '',
      fullName: json['full_name'] as String?,
      patronDeity: json['patron_deity'] as String? ?? 'Apollo',
      mythicTitle: json['mythic_title'] as String? ?? 'Initiate of Olympus',
      experiencePoints: json['experience_points'] as int? ?? 100,
      streakDays: json['streak_days'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'full_name': fullName,
      'patron_deity': patronDeity,
      'mythic_title': mythicTitle,
      'experience_points': experiencePoints,
      'streak_days': streakDays,
    };
  }
}
