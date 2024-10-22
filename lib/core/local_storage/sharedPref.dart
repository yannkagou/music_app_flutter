import 'dart:convert';

import 'package:client/features/auth/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static final SharedPreferencesServices _instance =
      SharedPreferencesServices._ctor();

  factory SharedPreferencesServices() {
    return _instance;
  }

  SharedPreferencesServices._ctor();

  static late SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  setUserInSharedPref(User user) {
    _prefs.setString("user", json.encode(user.toMap()));
  }

  User? getUserFromSharedPref() {
    if (!_prefs.containsKey('user')) {
      return null;
    }
    return User.fromMap(json.decode(_prefs.get('user') as String));
  }
}
