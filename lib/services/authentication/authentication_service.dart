// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../models/config_model.dart';
// import '../base_service/base_service.dart';
// import 'authentication_exceptions.dart';
// import 'iauthentication_service.dart';
//
//
//
// class AuthenticationService extends BaseService implements IAuthenticationService {
//
//   final AppConfigModel appConfig;
//   late final String _winladsAdminDomain;
//
//   AuthenticationService({required this.appConfig}) {
//     // Initialize domain from the injected Config Model
//     _winladsAdminDomain = appConfig.domainVariable.adminApiDomain;
//   }
//
//   AuthMeModel? authMeModel;
//   JWTTokenModel? jwtToken;
//   String _userProfileImage = "";
//
//   @override
//   String? get getProfileImage => _userProfileImage;
//
//   // --- Core Authentication ---
//
//   @override
//   Future<UserCredential?> signInWithEmailAndPassword({required String email, required String password}) async {
//     return await execute<UserCredential?>(() async {
//       try {
//         final credential = await auth.signInWithEmailAndPassword(email: email, password: password);
//         return credential;
//       } on FirebaseAuthException catch (e) {
//         throw ExceptionHandler.signInExceptions(e);
//       }
//     });
//   }
//
//   @override
//   Future<UserCredential?> signUpWithEmailAndPassword({required String email, required String password}) async {
//     return await execute<UserCredential?>(() async {
//       try {
//         final credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
//         return credential;
//       } on FirebaseAuthException catch (e) {
//         throw ExceptionHandler.signUpException(e);
//       }
//     });
//   }
//
//   @override
//   Future<void> signOut() async {
//     await execute(() async {
//       if (await GoogleSignIn().isSignedIn()) {
//         await GoogleSignIn().signOut();
//         await GoogleSignIn().disconnect();
//       }
//       await FacebookAuth.instance.logOut();
//       await auth.signOut();
//
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.remove('firstTimeSubscription');
//       prefs.remove('firstTime');
//       prefs.remove('lastShownDate');
//     });
//   }
//
//   // --- Social Auth ---
//
//   @override
//   Future<UserCredential?> signInWithGoogle() async {
//     return await execute<UserCredential?>(() async {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//       if (googleAuth == null) return null;
//
//       final googleCredential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       try {
//         return await auth.signInWithCredential(googleCredential);
//       } on FirebaseAuthException catch (e) {
//         throw ExceptionHandler.signInWithCredentialsException(e);
//       }
//     });
//   }
//
//   @override
//   Future<UserCredential?> signInWithFacebook() async {
//     // ... Implement logic using your _facebookCredential helper
//     // For brevity, I'm wrapping the core call
//     try {
//       // Your existing Facebook logic here
//       return null; // Placeholder for your complex Facebook logic
//     } catch(e) {
//       rethrow;
//     }
//   }
//
//   @override
//   Future<UserCredential?> signInWithApple() async {
//     // ... Implement Apple Sign In logic
//     return null;
//   }
//
//   // --- Profile & Data Management ---
//
//   @override
//   Future<AuthMeModel?> getUserDetails([bool forceRefresh = false]) async {
//     final user = auth.currentUser;
//     if (user == null) return null;
//
//     if (authMeModel != null && !forceRefresh) return authMeModel;
//
//     final tokenId = await user.getIdToken(true);
//     return await _getAuthMe(tokenId!);
//   }
//
//   Future<AuthMeModel?> _getAuthMe(String tokenId) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://$_winladsAdminDomain/auth/me'),
//         headers: {
//           'Authorization': 'Bearer $tokenId',
//           'Content-Type': 'application/json',
//         },
//       );
//
//       if (response.statusCode == 201) {
//         final responseData = jsonDecode(response.body);
//         // Note: Assuming you handle checking token details elsewhere or pass it in
//         // For now, using existing global jwtToken if available
//         authMeModel = AuthMeModel.fromJson(responseData, jwtToken!);
//         return authMeModel;
//       } else {
//         final responseData = jsonDecode(response.body);
//         throw CustomException(message: responseData['message'] ?? 'Failed to get user details');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   @override
//   Future<String> updateUserProfileImage(XFile image) async {
//     return await execute<String>(() async {
//       final user = auth.currentUser;
//       final storageRef = FirebaseStorage.instance.ref();
//       final imgRef = storageRef.child("userProfilePic/${user!.uid}/${DateTime.now()}.jpg");
//
//       File imgFile = File(image.path);
//       await imgRef.putFile(imgFile);
//       String url = await imgRef.getDownloadURL();
//
//       // Update backend
//       await updateUserDetails(displayName: authMeModel!.name!, profilePic: url);
//       _userProfileImage = url;
//       return url;
//     });
//   }
//
//   // --- Flow Logic (Handle Auth) ---
//
//   @override
//   Future<void> handleAuthentication() async {
//     final user = auth.currentUser;
//     final prefs = await SharedPreferences.getInstance();
//
//     if (user == null) {
//       bool? isOnboarding = prefs.getBool('firstTime');
//       // Navigation using Global Key
//       if (isOnboarding == null) {
//         globalNavigatorKey.currentState!.pushNamedAndRemoveUntil('/onboarding', (_) => false);
//       } else {
//         globalNavigatorKey.currentState!.pushNamedAndRemoveUntil('/signin', (_) => false);
//       }
//     } else {
//       // User is logged in, validate token
//       String? tokenId = await user.getIdToken(true);
//       jwtToken = await _checkTokenDetails(tokenId);
//       authMeModel = await _getAuthMe(tokenId!);
//
//       if (jwtToken != null && authMeModel != null) {
//         // Update Intercom
//         await Intercom.instance.loginIdentifiedUser(userId: authMeModel!.id ?? '');
//
//         // Routing Logic
//         if (jwtToken?.emailVerified == false) {
//           globalNavigatorKey.currentState!.pushNamedAndRemoveUntil('/verify_email', (_) => false, arguments: true);
//         } else if (jwtToken?.phoneNumber == null) {
//           globalNavigatorKey.currentState!.pushNamedAndRemoveUntil('/verify_account', (_) => false, arguments: true);
//         } else {
//           globalNavigatorKey.currentState!.pushNamedAndRemoveUntil('/home', (_) => false);
//         }
//       }
//     }
//   }
//
//   Future<JWTTokenModel?> _checkTokenDetails(String? tokenId) async {
//     Map<String, dynamic> decodedToken = JwtDecoder.decode(tokenId!);
//     return JWTTokenModel.fromJson(decodedToken);
//   }
//
//   // --- Missing Implementations from Interface ---
//   // You would implement the rest (verifyPhone, createUserDetails, etc)
//   // exactly as they are in your Repository, just ensuring you use 'auth' from BaseService
//   // and '_winladsAdminDomain' from the injected config.
//
//   @override
//   Future<void> changePassword(String currentPassword, String newPassword) async {
//     // Implementation from your repo...
//   }
//
//   @override
//   Future<void> closeAccount() async {
//     // Implementation from your repo...
//   }
//
//   @override
//   Future<void> createUserDetails({required String displayName, required String phoneNumber, required String referralNumber, required String dateOfBirth}) async {
//     // Implementation from your repo...
//   }
//
//   @override
//   Future<void> deleteUser() async {
//     // Implementation from your repo...
//   }
//
//   @override
//   Future<void> deleteUserProfileImage() async {
//     // Implementation from your repo...
//   }
//
//   @override
//   Future<void> sendPasswordResetEmail({required String email}) async {
//     // Implementation from your repo...
//   }
//
//   @override
//   Future<void> updateUserDetails({required String displayName, String? profilePic}) async {
//     // Implementation from your repo...
//   }
//
//   @override
//   Future<void> verifyOTPPhone({required String smsCode}) async {
//     // Implementation from your repo...
//   }
//
//   @override
//   Future<OtpResponse?> verifyPhone({required String phoneNumber}) async {
//     // Implementation from your repo...
//     return null;
//   }
// }
