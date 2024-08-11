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
  //? This function to create an account for the customer.
  Future<void> registerAsCustomer({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      await HttpConfig().checkConnectivity();
      Uri localLink = HttpConfig().getLinks(ApiConstants.register_path);
      http.Response res = await http.post(localLink,
          body: json.encode(<String, dynamic>{
            "full_name": name,
            "email": email,
            "password": password,
            "phone": int.tryParse(phoneNumber),
            "phone_code": "",
            "type": "customer",
          }),
          headers: HttpConfig().getHeader());
      Map<String, dynamic> data = json.decode(res.body);
      if (HttpConfig().validateStatusCode(res.statusCode)) {
        if (data["payload"] is! Map<String, dynamic>) {
          throw data["messages"];
        }
      } else {
        throw data["messages"];
      }
      TokenInfo token = TokenInfo.fromJson(data["payload"]);
      // The next line fo code will call the function to save the
      //personal info and the token in shared prefencess.
      await TokenService()
          .saveAuthData(email: email, password: password, token: token);
      // todo: Here will call the function to request the profile info
    } catch (error) {
      throw HttpConfig().handleError(error);
    }
  }

  Future<void> registerAsProvider({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String whatsApp,
    required String cityId,
    required String areaId,
  }) async {
    try {
      await HttpConfig().checkConnectivity();
      Uri localLink = HttpConfig().getLinks(ApiConstants.register_path);
      http.Response res = await http.post(localLink,
          body: json.encode(<String, dynamic>{
            "full_name": name,
            "email": email,
            "password": password,
            "phone": int.tryParse(phoneNumber),
            "phone_code": "",
            "whatsapp_number": whatsApp,
            "city_id": cityId,
            "area_id": areaId,
            "type": "service-owner",
          }),
          headers: HttpConfig().getHeader());
      Map<String, dynamic> data = json.decode(res.body);
      if (HttpConfig().validateStatusCode(res.statusCode)) {
        if (data["payload"] is! Map<String, dynamic>) {
          throw data["messages"];
        }
        TokenInfo token = TokenInfo.fromJson(data['payload']);
        await TokenService()
            .saveAuthData(email: email, password: password, token: token);
      } else {
        throw data["messages"];
      }
    } catch (error) {
      HttpConfig().handleError(error);
    }
  }
}
