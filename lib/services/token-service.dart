// ignore_for_file: file_names
//! This file will contain the functions that take handel
//! and save the [Token] and the personal info received from the API request in [shared preferences].

import 'package:ecommerceauth/models/token-info-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  saveAuthDatabyEmail(
      {required String email,
      required String password,
      required TokenInfo token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", token.token);
    pref.setString("email", email);
    pref.setString("password", password);
  }

  saveAuthDatabyPhone(
      {required String phoneNumber,
      required String password,
      required TokenInfo token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("token", token.token);
    pref.setString("phone", phoneNumber);
    pref.setString("password", password);
  }
}
