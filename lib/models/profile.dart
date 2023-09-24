import 'dart:convert';

class Profile {
  final String pfp;
  final String fullName;
  final String organization;
  final String country;

  final int followers;
  final int following;
  final int repoCount;
  Profile({
    required this.pfp,
    required this.fullName,
    required this.organization,
    required this.country,
    required this.followers,
    required this.following,
    required this.repoCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'pfp': pfp,
      'fullName': fullName,
      'organization': organization,
      'country': country,
      'followers': followers,
      'following': following,
      'repoCount': repoCount,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      pfp: map['avatar_url'] ?? '',
      fullName: map['name'] ?? '',
      organization: map['company'] ?? '',
      country: map['location'] ?? '',
      followers: map['followers']?.toInt() ?? 0,
      following: map['following']?.toInt() ?? 0,
      repoCount: map['public_repos']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));
}
