import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myevent/sharedPreference.dart';
import 'package:myevent/src/models/userResponse.dart';
import 'package:myevent/src/repositories/user/userRepository.dart';
import 'package:myevent/src/utils/result.dart';
import 'package:myevent/src/utils/validator.dart';
import 'package:rxdart/rxdart.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final SharedPreferencesHelper sharedPreferencesHelper;

  RegisterBloc({
    this.userRepository,
    this.sharedPreferencesHelper,
  }) : super(RegisterState.initial());

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
    Stream<RegisterEvent> events,
    TransitionFunction<RegisterEvent, RegisterState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! RegisterEmailChanged &&
          event is! RegisterPasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is RegisterEmailChanged ||
          event is RegisterPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangedToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangedToState(event.password);
    } else if (event is RegisterCPasswordChanged) {
      yield* _mapRegisterCPasswordChangedToState(
          event.password, event.cpassword);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(
          event.email, event.password, event.name);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapRegisterPasswordChangedToState(
      String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapRegisterCPasswordChangedToState(
      String password, String cPassword) async* {
    yield state.update(
      isCPasswordValid: Validators.isValidCPassword(password, cPassword),
    );
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      String email, String password, String name) async* {
    yield RegisterState.loading();
    try {
      Result<UserResponse> user =
          await userRepository.resgister(email, password, name);
      print(user.success);
      if (user.success.success) {
        await sharedPreferencesHelper.setToken(user.success.data.token);
        yield RegisterState.success();
      } else {
        yield RegisterState.failure();
      }
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
