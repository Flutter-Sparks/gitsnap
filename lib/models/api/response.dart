enum ResponseStatus { success, failed, unauthorized }

class ApiResponse {
  final Map<String, dynamic> data;
  final ResponseStatus status;
  ApiResponse({
    required this.data,
    required this.status,
  });
}
