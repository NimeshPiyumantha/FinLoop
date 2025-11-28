import 'package:firebase_auth/firebase_auth.dart';

import '../../globals.dart';

class ExceptionHandler {
  /// Handles exceptions during the Sign Up process
  static CustomException signUpException(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return CustomException(
          message:
              'An account already exists with this email address. Please use a different email or log in to your existing account.',
          errorCode: 409,
          functionName: 'signUpException',
        );
      case 'invalid-email':
        return CustomException(
          message:
              'The email address you entered is not valid. Please enter a valid email address and try again.',
          errorCode: 400,
          functionName: 'signUpException',
        );
      case 'operation-not-allowed':
        return CustomException(
          message:
              'Email and password sign-in is currently disabled. Please contact support.',
          errorCode: 403,
          functionName: 'signUpException',
        );
      case 'weak-password':
        return CustomException(
          message:
              'Your password is too weak. Please choose a stronger password.',
          errorCode: 400,
          functionName: 'signUpException',
        );
      case 'too-many-requests':
        return CustomException(
          message:
              'You’ve made too many attempts. Please wait a moment before trying again.',
          errorCode: 429,
          functionName: 'signUpException',
        );
      case 'network-request-failed':
        return CustomException(
          message: 'Network error: Please check your internet connection.',
          errorCode: 503,
          functionName: 'signUpException',
        );
      default:
        return CustomException(
          message: error.message ?? 'An unknown sign-up error occurred.',
          functionName: 'signUpException',
        );
    }
  }

  /// Handles exceptions during the Sign In process
  static CustomException signInExceptions(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-disabled':
        return CustomException(
          message: 'This account has been disabled. Please contact support.',
          errorCode: 403,
          functionName: 'signInExceptions',
        );
      case 'user-not-found':
      case 'invalid-email':
        return CustomException(
          message:
              'No account found with this email. Please checking your spelling or sign up.',
          errorCode: 404,
          functionName: 'signInExceptions',
        );
      case 'wrong-password':
      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return CustomException(
          message: 'Invalid credentials. Please check your email and password.',
          errorCode: 401,
          functionName: 'signInExceptions',
        );
      case 'too-many-requests':
        return CustomException(
          message: 'Too many attempts. Please wait a moment.',
          errorCode: 429,
          functionName: 'signInExceptions',
        );
      case 'user-token-expired':
        return CustomException(
          message: 'Session expired. Please log in again.',
          errorCode: 401,
          functionName: 'signInExceptions',
        );
      case 'network-request-failed':
        return CustomException(
          message: 'Network error. Please check your connection.',
          errorCode: 503,
          functionName: 'signInExceptions',
        );
      default:
        return CustomException(
          message: error.message ?? 'An unknown authentication error occurred.',
          functionName: 'signInExceptions',
        );
    }
  }

  /// Handles exceptions for Social/Credential Sign In
  static CustomException signInWithCredentialsException(
    FirebaseAuthException error,
  ) {
    switch (error.code) {
      case 'account-exists-with-different-credential':
        return CustomException(
          message:
              'An account already exists with this email using a different sign-in method.',
          errorCode: 409,
          functionName: 'signInWithCredentialsException',
        );
      case 'invalid-credential':
        return CustomException(
          message: 'The credential data is invalid or expired.',
          errorCode: 401,
          functionName: 'signInWithCredentialsException',
        );
      case 'operation-not-allowed':
        return CustomException(
          message: 'This sign-in method is currently disabled.',
          errorCode: 403,
          functionName: 'signInWithCredentialsException',
        );
      case 'user-disabled':
        return CustomException(
          message: 'This account has been disabled.',
          errorCode: 403,
          functionName: 'signInWithCredentialsException',
        );
      case 'invalid-verification-code':
        return CustomException(
          message: 'The invalid verification code. Please check and try again.',
          errorCode: 400,
          functionName: 'signInWithCredentialsException',
        );
      case 'invalid-verification-id':
        return CustomException(
          message: 'Invalid verification ID. Please request a new code.',
          errorCode: 400,
          functionName: 'signInWithCredentialsException',
        );
      default:
        return CustomException(
          message: error.message ?? 'An unknown credential error occurred.',
          functionName: 'signInWithCredentialsException',
        );
    }
  }

  /// Handles exceptions during Password Reset
  static CustomException resetPasswordException(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return CustomException(
          message: 'The email address is invalid.',
          errorCode: 400,
          functionName: 'resetPasswordException',
        );
      case 'user-not-found':
        return CustomException(
          message: 'No account found for this email address.',
          errorCode: 404,
          functionName: 'resetPasswordException',
        );
      case 'missing-android-pkg-name':
      case 'missing-ios-bundle-id':
      case 'missing-continue-uri':
      case 'invalid-continue-uri':
      case 'unauthorized-continue-uri':
        return CustomException(
          message:
              'Configuration error: Unable to send reset link. Contact support.',
          errorCode: 500,
          functionName: 'resetPasswordException',
        );
      default:
        return CustomException(
          message: error.message ?? 'Failed to send password reset email.',
          functionName: 'resetPasswordException',
        );
    }
  }
}
