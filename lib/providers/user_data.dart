import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  Map<String, dynamic>? userData;

  Map<String, dynamic>? get value => userData;

  setUserData(Map<String, dynamic> data) {
    userData = data;
    notifyListeners();
  }

  removeUser() {
    userData = null;
    notifyListeners();
  }
}
