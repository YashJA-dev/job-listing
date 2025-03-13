part of "../auth_bloc/auth_bloc.dart";

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String email;
  const AuthAuthenticated({required this.email});

  AuthAuthenticated copyWith({
    String? email,
  }) {
    return AuthAuthenticated(
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [email];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  AuthError copyWith({String? message}) {
    return AuthError(message ?? this.message);
  }

  @override
  List<Object> get props => [message];
}
