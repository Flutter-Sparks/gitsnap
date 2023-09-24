import 'dart:convert';
import 'dart:io';

import 'package:card_animation_gyro/models/api/response.dart';
import 'package:http/http.dart' as http;

class GitHubApi {
  Future<ApiResponse> getUserProfileData(String user) async {
    try {
      var url = Uri.https('api.github.com', 'users/$user');
      http.Response response = await http.get(url);
      Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ApiResponse(data: body, status: ResponseStatus.success);
      }
      return ApiResponse(data: body, status: ResponseStatus.failed);
    } on SocketException {
      throw ApiResponse(data: {}, status: ResponseStatus.failed);
    } catch (e) {
      throw ApiResponse(data: {}, status: ResponseStatus.failed);
    }
  }

  Future<ApiResponse> getUserRepoData(String user, String repo) async {
    try {
      var url = Uri.https('api.github.com', 'repos/$user/$repo');
      http.Response response = await http.get(url);
      Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ApiResponse(data: body, status: ResponseStatus.success);
      }
      return ApiResponse(data: body, status: ResponseStatus.failed);
    } catch (e) {
      return ApiResponse(data: {}, status: ResponseStatus.failed);
    }
  }
}
