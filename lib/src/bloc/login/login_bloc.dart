import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:myevent/sharedPreference.dart';
import 'package:myevent/src/models/userResponse.dart';
import 'package:myevent/src/repositories/user/userRepository.dart';
import 'package:myevent/src/utils/result.dart';
import 'package:myevent/src/utils/validator.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final SharedPreferencesHelper sharedPreferencesHelper;

  LoginBloc({
    this.userRepository,
    this.sharedPreferencesHelper,
  }) : super(LoginState.initial());

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events,
    TransitionFunction<LoginEvent, LoginState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! LoginEmailChanged && event is! LoginPasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is LoginEmailChanged || event is LoginPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEmailChanged) {
      yield* _mapLoginEmailChangedToState(event.email);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangedToState(event.password);
    } else if (event is PasswordReset) {
      yield* _mapPasswordResetPressedToState(email: event.email);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is LoginWithFacebookPressed) {
      yield* _mapLoginWithFacebookPressedToState();
    } else if (event is LoginWithTwitterPressed) {
      yield* _mapLoginWithTwitterPressedToState();
    }
  }

  Stream<LoginState> _mapLoginEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapLoginPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      Result<UserResponse> user = await userRepository.login(email, password);
      if (user.success.success) {
        await sharedPreferencesHelper.setToken(user.success.data.token);
        yield LoginState.success();
      } else {
        yield LoginState.failure();
      }
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapPasswordResetPressedToState({
    String email,
  }) async* {
    try {
      final token = await sharedPreferencesHelper.getToken();
      await userRepository.forgotpassword(token, email);
      yield LoginState.send();
    } catch (_) {
      yield LoginState.failSend();
    }
  }

  Stream<LoginState> _mapLoginWithFacebookPressedToState() async* {
    try {
      final facebookLogin = FacebookLogin();
      final result = await facebookLogin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      print(result.status);

      switch (result.status) {
        case FacebookLoginStatus.Success:
          Result<UserResponse> user =
              await userRepository.resgisterFacebook(result.accessToken.token);
          if (user.success.success) {
            await sharedPreferencesHelper.setToken(user.success.data.token);
            yield LoginState.success();
          } else {
            print("Api fail");
            yield LoginState.failure();
          }
          break;
        case FacebookLoginStatus.Cancel:
          yield LoginState.failure();
          break;
        case FacebookLoginStatus.Error:
          yield LoginState.failure();
          break;
      }
    } catch (error) {
      print(error);
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithTwitterPressedToState() async* {
    try {
      var twitterLogin = new TwitterLogin(
        consumerKey: 'w0wyqIHlGG3MsgFPalc2TG2aS',
        consumerSecret: 'XdrpBLE1a1rNeU29G0ljSHbZUA1RiqLrDkyW8rIl0l3K4q6Zkv',
      );

      final TwitterLoginResult result = await twitterLogin.authorize();

      switch (result.status) {
        case TwitterLoginStatus.loggedIn:
          var session = result.session;
          print(session.token);
          print(session.secret);
          Result<UserResponse> user = await userRepository.resgisterTwitter(
              session.token, session.secret);
          if (user.success.success) {
            await sharedPreferencesHelper.setToken(user.success.data.token);
            yield LoginState.success();
          } else {
            print("Api fail");
            yield LoginState.failure();
          }
          break;
        case TwitterLoginStatus.cancelledByUser:
          print("Cancel");
          yield LoginState.failure();
          break;
        case TwitterLoginStatus.error:
          print("Error");
          yield LoginState.failure();
          break;
      }
    } catch (error) {
      print(error);
      yield LoginState.failure();
    }
  }
}
