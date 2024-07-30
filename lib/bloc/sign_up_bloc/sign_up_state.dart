import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpSuccessState extends SignUpState {
  var sucessLogIn;
  SignUpSuccessState(this.sucessLogIn);
}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  String? err;
  SignUpFailureState(this.err);
}
