import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myevent/sharedPreference.dart';
import 'package:myevent/src/repositories/user/userRepository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  final SharedPreferencesHelper sharedPreferencesHelper;

  AuthBloc({this.userRepository, this.sharedPreferencesHelper})
      : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStarted) {
      yield* _mapAuthStartedToState();
    } else if (event is AuthLoggedIn) {
      yield* _mapAuthLoggedInToState();
    } else if (event is AuthFirst) {
      yield* _mapAuthFirstOpenState();
    } else if (event is AuthLoggedOut) {
      yield* _mapAuthLoggedOutToState();
    } else if (event is AuthLogin) {
      yield* _mapAuthLoginToState();
    } else if (event is AuthRegister) {
      yield* _mapAuthRegisterToState();
    }
  }

  Stream<AuthState> _mapAuthStartedToState() async* {
    final isSignedIn = await userRepository.hasToken();
    final firstOpen = await sharedPreferencesHelper.getIsFirstOpen();
    if (firstOpen == "oui") {
      yield AuthFirstOpen();
    } else {
      if (isSignedIn) {
        final token = await sharedPreferencesHelper.getToken();
        final userResult = await userRepository.getuser(token);
        yield AuthSuccess(userResult.success.data.user.name,
            userResult.success.data.user.email);
      } else {
        yield AuthFailure();
      }
    }
  }

  Stream<AuthState> _mapAuthLoggedInToState() async* {
    final firstOpen = await sharedPreferencesHelper.getIsFirstOpen();
    if (firstOpen == "oui") {
      yield AuthFirstOpen();
    } else {
      final token = await sharedPreferencesHelper.getToken();
      final userResult = await userRepository.getuser(token);
      yield AuthSuccess(userResult.success.data.user.name,
          userResult.success.data.user.email);
    }
  }

  Stream<AuthState> _mapAuthFirstOpenState() async* {
    await sharedPreferencesHelper.setIsFirstOpen("non");
    yield AuthFailure();
  }

  Stream<AuthState> _mapAuthLoggedOutToState() async* {
    final token = await sharedPreferencesHelper.getToken();
    userRepository.logout(token);
    await sharedPreferencesHelper.deleteToken();
    yield AuthFailure();
  }

  Stream<AuthState> _mapAuthLoginToState() async* {
    yield AuthLoginState(userRepository: userRepository);
  }

  Stream<AuthState> _mapAuthRegisterToState() async* {
    yield AuthRegisterState(userRepository: userRepository);
  }
}
