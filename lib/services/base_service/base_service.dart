import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../globals.dart';

/// [BaseService]
/// A foundational abstract class that provides shared dependencies (Firebase)
/// and standardized error handling mechanisms for all services.
abstract class BaseService {
  @protected
  final FirebaseAuth auth = FirebaseAuth.instance;

  @protected
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// A wrapper method to standardize error handling across all services.
  /// [action] is the asynchronous function to execute.
  /// Returns [T], the expected result type.
  @protected
  Future<T> execute<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (e) {
      throw CustomException(
        message: e.message ?? 'Authentication failed',
        errorCode: int.tryParse(e.code) ?? 500,
        functionName: 'BaseService.execute',
      );
    } on FirebaseException catch (e) {
      throw CustomException(
        message: e.message ?? 'Database operation failed',
        errorCode: int.tryParse(e.code) ?? 500,
        functionName: 'BaseService.execute',
      );
    } catch (e) {
      throw CustomException(
        message: e.toString(),
        functionName: 'BaseService.execute',
      );
    }
  }
}
