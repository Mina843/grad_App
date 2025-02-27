import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading()); // تغيير الحالة إلى تحميل

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess()); // تسجيل الدخول ناجح
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(
          errorMessage: e.message ?? "Login failed")); // خطأ في تسجيل الدخول
    }
  }
}
