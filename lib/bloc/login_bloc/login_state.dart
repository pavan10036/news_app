import 'package:equatable/equatable.dart';

class LogInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogInSuccessState extends LogInState {
  var sucessLogIn;
  LogInSuccessState(this.sucessLogIn);
}

class LogInInitialState extends LogInState {}

class LogInLoadingState extends LogInState {}

class LogInFailureState extends LogInState {
  String? err;
  LogInFailureState(this.err);
}
