
import 'package:input_flutter/core/api/services/aut.service.dart';

class ApiClient{
  static String get baseUrl => "https://input-server.herokuapp.com";

  static AuthService get authService => AuthService();

}