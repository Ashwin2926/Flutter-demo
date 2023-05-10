import 'dart:io';
import 'package:fl_firebase/models/users_list_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'api_status.dart';

class Userservices {
  static Future<Object> getUsers() async {
    try {
      var url = Uri.parse(USERS_LIST);
      var response = await http.get(url);

      if (200 == response.statusCode) {
        return Success(response: userModelFromJson(response.body), code: 200);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}
