import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/model/user_model.dart';
import 'package:stor/modules/login/login_cubit/login_state.dart';
import 'package:stor/shared/service/network/dio_helper.dart';
import 'package:stor/shared/service/network/end_boint.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  UserStatusModel? userModel;
  IconData suffix = Icons.visibility;
  bool showPass = true;
  void showPassWord() {
    showPass = !showPass;
    suffix = showPass ? Icons.visibility : Icons.visibility_off;
    emit(LoginShowPassword());
  }

  void userLoginData({required String email, required String password}) {
    emit(LoginLodingState());
    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      userModel = UserStatusModel.fromJson(value.data);

      emit(
        LoginScassesState(userModel: userModel!),
      );
    }).catchError((e) {
      log(e.toString());
      emit(
        LoginErrorState(e.toString()),
      );
    });
  }
}
