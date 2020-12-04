import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:myevent/src/api/apiService.dart';
import 'package:myevent/src/api/user/userApiService.dart';

class UserApiServiceFactory implements UserApiService {
  final ApiService apiService;

  UserApiServiceFactory({this.apiService});

  @override
  Future<Response> login(String email, String password) async {
    Response response;

    try {
      response = await apiService.login({"email": email, "password": password});
    } catch (e) {
      print('Caught ${e.body}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> getUser(String token) async {
    Response response;
    try {
      response = await apiService.getuser('Bearer ' + token);
    } catch (e) {
      print('Caught ${e.body}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> logout(String token) async {
    Response response;
    try {
      response = await apiService.logout('Bearer ' + token);
    } catch (e) {
      print('Caught ${e.body}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> forgotPassword(String token, String email) async {
    Response response;

    try {
      response =
          await apiService.forgetPassword('Bearer ' + token, {"email": email});
    } catch (e) {
      print('Caught ${e.body}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> register(String email, String password, String name) async {
    Response response;

    try {
      response = await apiService.register({
        "email": email,
        "password": password,
        "c_password": password,
        "name": name
      });
    } catch (e) {
      print('Caught ${e.body}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> registerFacebook(String token) async {
    Response response;

    try {
      response = await apiService.registerFacebook({"token": token});
    } catch (e) {
      print('Caught ${e.body}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> registerTwitter(String token, String secret) async {
    Response response;

    try {
      response =
          await apiService.registerTwitter({"token": token, "secret": secret});
    } catch (e) {
      print('Caught ${e.body}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> updateUser(String token,
      {String name,
      int telephone,
      String fcmToken,
      String platform,
      File avatar}) async {
    Response response;

    try {
      response = await apiService.updateuser('Bearer ' + token, {
        "name": name,
        "telephone": telephone,
        "fcmToken": fcmToken,
        "platform": platform,
        "avatar": avatar
      });
    } catch (e) {
      print('Caught ${e.body}');
      rethrow;
    }
    return response;
  }
}
