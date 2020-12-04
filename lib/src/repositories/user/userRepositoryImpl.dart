import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:myevent/sharedPreference.dart';
import 'package:myevent/src/api/user/userApiService.dart';
import 'package:myevent/src/models/userResponse.dart';
import 'package:myevent/src/models/responseApi.dart';
import 'package:myevent/src/repositories/user/userRepository.dart';
import 'package:myevent/src/utils/networkInfo.dart';
import 'package:myevent/src/utils/result.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserApiService userApiService;
  final SharedPreferencesHelper sharedPreferencesHelper;

  UserRepositoryImpl(
      {this.networkInfo, this.userApiService, this.sharedPreferencesHelper});

  @override
  Future<bool> deleteToken() async {
    bool delete = await sharedPreferencesHelper.deleteToken();
    return delete;
  }

  @override
  Future<Result<ResponseApi>> forgotpassword(String token, String email) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final Response response =
            await userApiService.forgotPassword(token, email);

        var model = ResponseApi.fromJson(response.body);

        return Result(success: model);
      } catch (e) {
        return Result(error: ServerError());
      }
    } else {
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<UserResponse>> getuser(String token) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final Response response = await userApiService.getUser(token);

        var model = UserResponse.fromJson(response.body);

        return Result(success: model);
      } catch (e) {
        return Result(error: ServerError());
      }
    } else {
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<bool> hasToken() async {
    bool hasToken;
    String token = await sharedPreferencesHelper.getToken();
    if (token != null) {
      hasToken = true;
    } else {
      hasToken = false;
    }

    return hasToken;
  }

  @override
  Future<Result<UserResponse>> login(String email, String password) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final Response response = await userApiService.login(email, password);

        var model = UserResponse.fromJson(response.body);

        return Result(success: model);
      } catch (e) {
        return Result(error: ServerError());
      }
    } else {
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<ResponseApi>> logout(String token) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final Response response = await userApiService.logout(token);

        var model = ResponseApi.fromJson(response.body);

        return Result(success: model);
      } catch (e) {
        return Result(error: ServerError());
      }
    } else {
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<UserResponse>> resgister(
      String email, String password, String name) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final Response response =
            await userApiService.register(email, password, name);

        var model = UserResponse.fromJson(response.body);

        return Result(success: model);
      } catch (e) {
        return Result(error: ServerError());
      }
    } else {
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<UserResponse>> resgisterFacebook(String token) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final Response response = await userApiService.registerFacebook(token);

        var model = UserResponse.fromJson(response.body);

        return Result(success: model);
      } catch (e) {
        return Result(error: ServerError());
      }
    } else {
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<Result<UserResponse>> resgisterTwitter(
      String token, String secret) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final Response response =
            await userApiService.registerTwitter(token, secret);

        var model = UserResponse.fromJson(response.body);

        return Result(success: model);
      } catch (e) {
        return Result(error: ServerError());
      }
    } else {
      return Result(error: NoInternetError());
    }
  }

  @override
  Future<bool> saveToken(String token) async {
    bool saveT = await sharedPreferencesHelper.setToken(token);
    return saveT;
  }

  @override
  Future<Result<UserResponse>> updateuser(String token,
      {String name,
      int telephone,
      String fcmToken,
      String platform,
      File avatar}) async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        final Response response = await userApiService.updateUser(token,
            name: name ?? null,
            telephone: telephone ?? null,
            fcmToken: fcmToken ?? null,
            platform: platform ?? null,
            avatar: avatar ?? null);

        var model = UserResponse.fromJson(response.body);

        return Result(success: model);
      } catch (e) {
        return Result(error: ServerError());
      }
    } else {
      return Result(error: NoInternetError());
    }
  }
}
