//! This file will take care about all configuration regarding the Api connection.
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerceauth/http/api_constants.dart';

class HttpConfig {
  static const String baseUrl = "${ApiConstants.server_protocall}wafraa.net";

//? This function is responsabile to provide the complete path for all API requests.
  Uri getLinks(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) {
    return Uri.https(baseUrl, "/api/$path", queryParameters);
  }

//? This function is responsabile to provide the header for all API requests.
  Map<String, String> getHeader({String? token, String? contentType}) {
    return <String, String>{
      "Accept": "application/json",
      "Content-Type": contentType ?? "application/json",
      if (token != null) "Authorization": token,
    };
  }

//? This function is responsabile to handel all errors related to the API requests.
  String handleError(dynamic messages) {
    if (messages is String) {
      return messages;
    } else if (messages is Map<String, dynamic>) {
      String errors = "";
      // ignore: always_specify_types
      for (var error in (messages).values) {
        errors += error is List<dynamic> ? error.join(", ") : error.toString();
      }
      return errors;
    } else {
      return "something-went-wrong";
    }
  }

  Future<void> checkConnectivity() async {
    List<ConnectivityResult> con = await Connectivity().checkConnectivity();
    if (con.contains(ConnectivityResult.none) ||
        con.contains(ConnectivityResult.bluetooth)) {
      throw "no-connection";
    }
  }

  bool validateStatusCode(int? statusCode) {
    return statusCode == 200 || statusCode == 201;
  }
}
