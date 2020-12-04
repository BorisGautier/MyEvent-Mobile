import 'dart:io';

import 'package:chopper/chopper.dart';

abstract class UserApiService {
  Future<Response> login(String email, String password);

  Future<Response> register(String name, String email, String password);

  Future<Response> registerFacebook(String token);

  Future<Response> registerTwitter(String token, String secret);

  Future<Response> getUser(String token);

  Future<Response> forgotPassword(String token, String email);

  Future<Response> updateUser(String token,
      {String name,
      int telephone,
      String fcmToken,
      String platform,
      File avatar});

  Future<Response> logout(String token);
}
