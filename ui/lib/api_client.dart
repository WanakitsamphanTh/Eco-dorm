import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  String studentId = "";
  String authToken = "";

  ApiClient(this.baseUrl);

  Future<bool> login(String studentId) async {
    final url = Uri(scheme: 'http', host: baseUrl, port: 5000, path: '/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: '{"student_id": "$studentId"}',
    );
    if (response.statusCode != 200) return false;
    return true;
  }

  Future<http.Response> fetchScore(String token) async {
    final url = Uri(scheme: 'http', host: baseUrl, port: 5000, path: '/score');
    return await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<http.Response> fetchCoupons(String token) async {
    final url = Uri(scheme: 'http', host: baseUrl, port: 5000, path: '/coupons');
    return await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}