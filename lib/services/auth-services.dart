//! This file contains all necessary functions for the authentication.

//? TO login with the phone number.
// *Todo: Should return all info of cux AFTER completing
import 'dart:convert';

import 'package:ecommerceauth/http/http-config.dart';
import 'package:ecommerceauth/services/token-service.dart';
import 'package:http/http.dart' as http;

import '../http/api_constants.dart';
import '../models/token-info-model.dart';

//? TO login with the email address.
Future<void> loginByPhone({
  required String phone,
  required String password,
}) async {
  try {} catch (e) {
    throw HttpConfig().handleError(e);
  }
}

//? TO login with the email address.
Future<void> loginByEmail(
    {required String email, required String password}) async {
  try {
    await HttpConfig().checkConnectivity();
    Uri localLink = HttpConfig().getLinks(ApiConstants.login_by_email_path);
    http.Response res = await http.post(
      localLink,
      body: json.encode(
        <String, dynamic>{
          "email": email,
          "password": password,
        },
      ),
      headers: HttpConfig().getHeader(),
    );
    Map<String, dynamic> data = json.decode(res.body);
    if (HttpConfig().validateStatusCode(res.statusCode)) {
      if (data["payload"] is! Map<String, dynamic>) {
        throw data["messages"];
      }
      TokenInfo token = TokenInfo.fromJson(data["payload"]);
      // The next line fo code will call the function to save the
      //personal info and the token in shared prefencess.
      await TokenService()
          .saveAuthData(email: email, password: password, token: token);
      // todo: Here will call the function to request the profile info
    } else {
      throw data["messages"];
    }
  } catch (e) {
    throw HttpConfig().handleError(e);
  }
  //? TO login with the email address.
  Future registerAsCustomer() async {}
}
