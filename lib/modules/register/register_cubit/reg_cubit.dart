import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/model/user_model.dart';
import 'package:stor/modules/register/register_cubit/register_state.dart';
import 'package:stor/shared/service/network/dio_helper.dart';
import 'package:stor/shared/service/network/end_boint.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserStatusModel? userModel;
  IconData suffix = Icons.visibility;
  bool showPass = true;
  void showPassWord() {
    showPass = !showPass;
    suffix = showPass ? Icons.visibility : Icons.visibility_off;
    emit(RegisterShowPassword());
  }

  void userRegisterData({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLodingState());
    DioHelper.postData(url: register, data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "image": ""
    }).then((value) {
      userModel = UserStatusModel.fromJson(value.data);

      emit(
        RegisterScassesState(userModel: userModel!),
      );
    }).catchError((e) {
      log(e.toString());
      emit(
        RegisterErrorState(e.toString()),
      );
    });
  }
}
