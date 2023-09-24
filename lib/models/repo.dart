import 'dart:convert';

class Repository {
  final String repoName;
  final String bio;
  final List<String> tags;
  final int stars;
  final int forks;
  final String language;
  final String userPFP;
  final String userName;
  Repository({
    required this.repoName,
    required this.bio,
    required this.tags,
    required this.stars,
    required this.forks,
    required this.language,
    required this.userPFP,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'repoName': repoName,
      'bio': bio,
      'tags': tags,
      'stars': stars,
      'forks': forks,
      'language': language,
      'userPFP': userPFP,
      'userName': userName,
    };
  }

  factory Repository.fromMap(Map<String, dynamic> map) {
    return Repository(
      repoName: map['name'] ?? '',
      bio: map['description'] ?? '',
      tags: List<String>.from(map['topics']),
      stars: map['watchers']?.toInt() ?? 0,
      forks: map['forks']?.toInt() ?? 0,
      language: map['language'] ?? '',
      userPFP: map['owner']['avatar_url'] ?? '',
      userName: map['owner']['login'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Repository.fromJson(String source) =>
      Repository.fromMap(json.decode(source));
}
