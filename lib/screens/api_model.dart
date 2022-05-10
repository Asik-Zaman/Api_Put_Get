import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  Future<LoginApiResponse> apiCallLogin(Map<String, dynamic> param) async {
    var url = Uri.parse('http://mamun.click/api/login');
    var response = await http.post(url, body: param);

    // print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    final data = jsonDecode(response.body);

    //var token = data["token"]["plainTextToken"];
    //print(token);
    return LoginApiResponse(
        username: data['data']['username'],
        phone: data['data']['phone'],
        email: data['data']['email'],
        token: data["token"]["plainTextToken"],
        error: data["error"]);
  }
}

class LoginApiResponse {
  final String? username;
  final String? phone;
  final String? email;
  final String? token;
  final String? error;

  LoginApiResponse(
      {this.username, this.phone, this.email, this.token, this.error});
}
