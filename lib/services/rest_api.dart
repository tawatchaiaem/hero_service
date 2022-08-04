import 'dart:convert';

import 'package:http/http.dart' as http;

class CallAPI {
  _setHeaders() => {'Content-Type': 'application/json', 'Accept': '*/*'};
  final String baseAPIURL =
      'https://www.itgenius.co.th/sandbox_api/flutteradvapi/public/api/';

  

  // Login API
  loginAPI(data) async { 
    print(baseAPIURL);
    return await http.post(
      Uri.parse(baseAPIURL + 'login'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }
}
