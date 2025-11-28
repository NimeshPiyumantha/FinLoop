// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:meta/meta.dart';
//
// import '../../services/authentication/iauthentication_service.dart';
//
// part 'auth_event.dart';
// part 'auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   // final IAuthenticationService _authService;
//
//   AuthBloc({required IAuthenticationService authService})
//       : _authService = authService,
//         super(AuthInitial()) {
//
//     on<AuthCheckRequested>(_onAuthCheckRequested);
//     on<AuthLogoutRequested>(_onAuthLogoutRequested);
//   }
//
//   Future<void> _onAuthCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       // Trigger the complex handle logic in service
//       await _authService.handleAuthentication();
//       // NOTE: Since handleAuthentication handles navigation internally via GlobalKeys,
//       // the state here might just be for UI updates.
//       // Ideally, the Service shouldn't navigate, but based on your legacy code, it does.
//     } catch (e) {
//       emit(AuthUnauthenticated());
//     }
//   }
//
//   Future<void> _onAuthLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
//     await _authService.signOut();
//     emit(AuthUnauthenticated());
//   }
// }
