import 'package:flutter/foundation.dart';
import 'package:input_flutter/core/api/api_client.dart';
import 'package:input_flutter/core/models/auth.model.dart';
import 'package:input_flutter/meta/utils/shared_pref.dart';

class AuthNotifier extends ChangeNotifier {
  AuthModel currentSpyder = AuthModel.emptyAuth();

  Future<bool> verifySecret(String secret) async {
    currentSpyder = await ApiClient.authService.getUser(secret: secret);
    debugPrint(currentSpyder.toJson().toString());
    if(currentSpyder.userId != ''){
      saveUserState(currentSpyder.userId!, currentSpyder.name!);
    }
    notifyListeners();
    return currentSpyder.userId != null;
  }

  Future<bool> renewSession(String id) async {
    currentSpyder = await ApiClient.authService.getUserById(id: id);
    debugPrint(currentSpyder.toJson().toString());
    notifyListeners();
    return currentSpyder.userId != null;
  }

  Future<String?> getUserId() async {
    return SharedPref().pref.getString('user-id');
  }

  Future<String?> getUserName() async {
    return SharedPref().pref.getString('name');
  }

  void saveUserState(String userId, String name){
    SharedPref().pref.setString('user-id', userId);
    SharedPref().pref.setString('name', name);
  }
}
