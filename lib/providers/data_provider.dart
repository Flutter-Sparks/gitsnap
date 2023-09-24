import 'package:card_animation_gyro/api/github_api_helper.dart';
import 'package:card_animation_gyro/models/api/response.dart';
import 'package:card_animation_gyro/models/profile.dart';
import 'package:card_animation_gyro/models/repo.dart';
import 'package:flutter/cupertino.dart';

class UserDataProvider extends ChangeNotifier {
  final GitHubApi _api = GitHubApi();

  final String _selectedBackground = 'bg1.jpg';
  String get selectedBackground => _selectedBackground;

  Future<Profile?> getProfile(String profile) async {
    try {
      ApiResponse response = await _api.getUserProfileData(profile);
      if (response.status == ResponseStatus.success) {
        return Profile.fromMap(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Repository?> getRepository(String profile, String repo) async {
    try {
      ApiResponse response = await _api.getUserRepoData(profile, repo);

      if (response.status == ResponseStatus.success) {
        return Repository.fromMap(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
