import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:input_flutter/core/api/api_client.dart';
import 'package:input_flutter/core/models/auth.model.dart';

class AuthService {
  final _client = http.Client();

  Future<AuthModel> getUser({required String secret}) async {
    try {
      var url = Uri.parse("${ApiClient.baseUrl}/user");
      http.Response response = await _client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'secret': secret,
          })
      );
      if (response.statusCode == 200) {
        return AuthModel.fromJson(jsonDecode(response.body));
      }else{
        return AuthModel.emptyAuth();
      }
    } catch (e) {
      debugPrint(e.toString());
      return AuthModel.emptyAuth();
    }
    return AuthModel.emptyAuth();
  }


  Future<AuthModel> getUserById({required String id}) async {
    try {
      var url = Uri.parse("${ApiClient.baseUrl}/user/$id");
      http.Response response = await _client.get(url
      );
      if (response.statusCode == 200) {
        return AuthModel.fromJson(jsonDecode(response.body));
      }else{
        return AuthModel.emptyAuth();
      }
    } catch (e) {
      debugPrint(e.toString());
      return AuthModel.emptyAuth();
    }
    return AuthModel.emptyAuth();
  }

}