import 'dart:convert';

import 'package:hero_service_app/models/LoginModel.dart';
import 'package:http/http.dart' as http;

class CallAPI {
  _setHeaders() => {'Content-Type': 'application/json', 'Accept': '*/*'};
  final String baseAPIURL =
      'https://www.itgenius.co.th/sandbox_api/flutteradvapi/public/api/';

  // Login API
  loginAPI(data) async {
    print(baseAPIURL);
    print(data);
    return await http.post(
      Uri.parse(baseAPIURL + 'login'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // Read User Profile
  Future<LoginModel?> getProfile(data) async {
    final response = await http.post(
      Uri.parse(baseAPIURL + 'login'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );

    if (response.statusCode == 200) {
      return loginModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
