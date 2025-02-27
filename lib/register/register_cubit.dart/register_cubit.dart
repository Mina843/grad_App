import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(
      {required String email, required String password}) async {
    emit(RegisterLoading()); // تغيير الحالة إلى تحميل

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccess()); // نجاح التسجيل
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      emit(RegisterFailure(
          errorMessage: e.message ?? "Registration failed")); // فشل التسجيل
    }
  }
}
