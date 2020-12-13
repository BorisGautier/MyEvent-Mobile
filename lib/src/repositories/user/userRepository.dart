import 'dart:io';

import 'package:myevent/src/models/responseApi.dart';
import 'package:myevent/src/models/userResponse.dart';
import 'package:myevent/src/utils/result.dart';

abstract class UserRepository {
  Future<Result<UserResponse>> login(String email, String password);

  Future<Result<UserResponse>> resgister(
      String email, String password, String name);

  Future<Result<UserResponse>> resgisterFacebook(String token);

  Future<Result<UserResponse>> resgisterTwitter(String token, String secret);

  Future<Result<UserResponse>> updateuser(String token,
      {String name,
      int telephone,
      String fcmToken,
      String platform,
      File avatar});

  Future<Result<UserResponse>> getuser(String token);

  Future<Result<ResponseApi>> forgotpassword(String email);

  Future<bool> deleteToken();

  Future<bool> saveToken(String token);

  Future<bool> hasToken();

  Future<Result<ResponseApi>> logout(String token);
}
