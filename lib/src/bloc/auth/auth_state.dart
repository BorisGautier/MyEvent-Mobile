part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final String name;
  final String email;

  const AuthSuccess(this.name, this.email);

  @override
  List<Object> get props => [name, email];

  @override
  String toString() => 'AuthSuccess { Name: $name , email: $email }';
}

class AuthFirstOpen extends AuthState {}

class AuthFailure extends AuthState {}

class AuthLoginState extends AuthState {
  final UserRepository userRepository;

  const AuthLoginState({
    @required this.userRepository,
  });

  @override
  List<Object> get props => [userRepository];

  @override
  String toString() {
    return 'AuthLoginState { userRepository: $userRepository }';
  }
}

class AuthRegisterState extends AuthState {
  final UserRepository userRepository;

  const AuthRegisterState({
    @required this.userRepository,
  });

  @override
  List<Object> get props => [userRepository];

  @override
  String toString() {
    return 'AuthRegister { userRepository: $userRepository }';
  }
}
