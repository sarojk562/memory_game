import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  User? userData;

  addUser(User data) {
    userData = data;
    notifyListeners();
  }

  removeUser() {
    userData = null;
    notifyListeners();
  }
}
