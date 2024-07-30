import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/sign_up_bloc/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitialState());

  createUserWithEmailAndPassword(String? email, String? password) async {
    try {
      emit(SignUpLoadingState());
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email ?? "",
        password: password ?? "",
      );
      emit(
        SignUpSuccessState(data),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          SignUpFailureState(
            e.code.toString(),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          SignUpFailureState(
            e.code.toString(),
          ),
        );
      } else {
        email != "" && password != ""
            ? emit(
                SignUpFailureState(
                  "Invalid email or password",
                ),
              )
            : SignUpInitialState();
      }
    }
  }
}
