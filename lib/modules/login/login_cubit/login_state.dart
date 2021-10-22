import 'package:stor/model/user_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLodingState extends LoginState {}

class LoginScassesState extends LoginState {
  UserStatusModel userModel;
  LoginScassesState({
    required this.userModel,
  });
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}

class LoginShowPassword extends LoginState {}
