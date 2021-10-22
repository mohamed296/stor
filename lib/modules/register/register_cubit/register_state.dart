import 'package:stor/model/user_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLodingState extends RegisterState {}

class RegisterScassesState extends RegisterState {
  UserStatusModel userModel;
  RegisterScassesState({
    required this.userModel,
  });
}

class RegisterErrorState extends RegisterState {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterShowPassword extends RegisterState {}
