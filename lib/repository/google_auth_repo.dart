import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:joblisting/repository/base_api_repo.dart';

class GoogleAuthRepo extends BaseApiRepo {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  GoogleAuthRepo({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _googleSignIn = googleSignIn;

  /// Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log("SIGN IN ERROR: ${e.code} - ${e.message}");
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      log("SIGN IN ERROR: ${e.toString()}");
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  /// Sign up with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log("SIGN UP ERROR: ${e.code} - ${e.message}");
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      log("SIGN UP ERROR: ${e.toString()}");
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  /// Check if user is signed in
  Future<bool> isSignedIn() async {
    return _auth.currentUser != null;
  }

  /// Get currently signed-in user
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  /// Sign out the user
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      log("SIGN OUT ERROR: ${e.toString()}");
      throw Exception("Failed to sign out. Please try again.");
    }
  }

  /// Handle FirebaseAuthException with meaningful messages
  Exception _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return Exception("The email address is not valid.");
      case 'user-not-found':
        return Exception("No user found with this email.");
      case 'wrong-password':
        return Exception("Incorrect password.");
      case 'email-already-in-use':
        return Exception("This email is already registered.");
      case 'weak-password':
        return Exception("The password is too weak.");
      case 'network-request-failed':
        return Exception("Network error. Please check your connection.");
      default:
        return Exception("Authentication failed. Please try again.");
    }
  }
}
