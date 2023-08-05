import 'dart:convert';

import 'package:flut_auth/model/login_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> login(LoginRequestModel requestModel) async {
    try {
      String url = 'http://10.0.2.2:5000/api/login';
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8'
      };

      http.Response res = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(requestModel.toJson()),
      );
      var result = jsonDecode(res.body);
      print(jsonDecode(res.body));
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
