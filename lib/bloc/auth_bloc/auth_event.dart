part of "../auth_bloc/auth_bloc.dart";

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUp({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthLoggedIn extends AuthEvent {
  final String email;
  final String password;

  const AuthLoggedIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthLoggedOut extends AuthEvent {}

class AuthCheckLoggedIn extends AuthEvent {}
