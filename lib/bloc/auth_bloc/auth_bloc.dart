import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joblisting/repository/google_auth_repo.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleAuthRepo googleAuthRepo;
  AuthBloc({required this.googleAuthRepo}) : super(AuthInitial()) {
    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthCheckLoggedIn>(_onAuthCheckLoggedIn);
    on<AuthLoggedOut>(_authLogOut);
    on<AuthSignUp>(_authSignUp);
  }

  FutureOr<void> _onAuthLoggedIn(
      AuthLoggedIn event, Emitter<AuthState> emit) async {
    try {
      User? user = await googleAuthRepo.signIn(event.email, event.password);
      if (user != null) {
        emit(AuthAuthenticated(email: user!.email!));
      } else {
        emit(AuthError("Something went wrong"));
      }
    } catch (e) {
      emit(AuthError(_extractErrorMessage(e)));
    }
  }

  FutureOr<void> _onAuthCheckLoggedIn(
      AuthCheckLoggedIn event, Emitter<AuthState> emit) async {
    try {
      bool logedIn = await googleAuthRepo.isSignedIn();
      User? user = await googleAuthRepo.getCurrentUser();

      if (logedIn && user != null) {
        emit(AuthAuthenticated(email: user.email ?? ""));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  FutureOr<void> _authLogOut(
      AuthLoggedOut event, Emitter<AuthState> emit) async {
    try {
      await googleAuthRepo.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(_extractErrorMessage(e)));
    }
  }

  FutureOr<void> _authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    try {
      User? user = await googleAuthRepo.signUp(event.email, event.password);
      if (user != null) {
        emit(AuthAuthenticated(email: user.email!));
      } else {
        emit(AuthError("Something went wrong"));
      }
    } catch (e) {
      emit(AuthError(_extractErrorMessage(e)));
    }
  }
}

String _extractErrorMessage(dynamic e) {
  if (e is Exception) {
    return e
        .toString()
        .replaceFirst("Exception: ", ""); // Remove "Exception: " prefix
  }
  return "An unexpected error occurred. Please try again.";
}
