// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:winladsclient/models/auth_model.dart';
// import 'package:winladsclient/models/otp_response_model.dart';
//
// /// [IAuthenticationService]
// /// Abstract contract for Authentication.
// /// This replaces 'BaseAuthRepositories' to follow the Service pattern.
// abstract class IAuthenticationService {
//
//   // Core Auth
//   Future<UserCredential?> signInWithEmailAndPassword({required String email, required String password});
//   Future<UserCredential?> signUpWithEmailAndPassword({required String email, required String password});
//   Future<void> signOut();
//   Future<void> deleteUser();
//
//   // Social Auth
//   Future<UserCredential?> signInWithGoogle();
//   Future<UserCredential?> signInWithFacebook();
//   Future<UserCredential?> signInWithApple();
//
//   // Profile Management
//   Future<AuthMeModel?> getUserDetails([bool forceRefresh = false]);
//   Future<void> updateUserDetails({required String displayName, String? profilePic});
//   Future<void> createUserDetails({
//     required String displayName,
//     required String phoneNumber,
//     required String referralNumber,
//     required String dateOfBirth
//   });
//   Future<String> updateUserProfileImage(XFile image);
//   String? get getProfileImage;
//
//   // Verification & Security
//   Future<OtpResponse?> verifyPhone({required String phoneNumber});
//   Future<void> verifyOTPPhone({required String smsCode});
//   Future<void> sendPasswordResetEmail({required String email});
//   Future<void> changePassword(String currentPassword, String newPassword);
//
//   // Flow Handlers
//   Future<void> handleAuthentication();
// }
