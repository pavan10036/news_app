import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitialState());

  signInWithEmailAndPassword(String? email, String? password) async {
    try {
      emit(LogInLoadingState());
      var data = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email ?? "", password: password ?? "");
      emit(
        LogInSuccessState(data),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(
          LogInFailureState(
            e.code.toString(),
          ),
        );
      } else if (e.code == 'wrong-password') {
        emit(
          LogInFailureState(
            e.code.toString(),
          ),
        );
      } else {
        email != "" && password != ""
            ? emit(
                LogInFailureState(
                  "Invalid email or password",
                ),
              )
            : LogInInitialState();
      }
    }
  }
}
