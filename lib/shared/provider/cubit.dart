import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/model/add_favorites_model.dart';
import 'package:stor/model/category_model.dart';
import 'package:stor/model/favorites_data_model.dart';
import 'package:stor/model/home_model.dart';
import 'package:stor/model/user_model.dart';
import 'package:stor/modules/category/category_modules.dart';
import 'package:stor/modules/favorite/favorite_modules.dart';
import 'package:stor/modules/home/home_modules.dart';
import 'package:stor/modules/settings/settings_modules.dart';
import 'package:stor/shared/provider/state.dart';
import 'package:stor/shared/service/network/dio_helper.dart';
import 'package:stor/shared/service/network/end_boint.dart';
import 'package:stor/shared/widget/constante.dart';

class StorCubit extends Cubit<StorState> {
  StorCubit() : super(StorInatioalState());
  static StorCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screan = [
    const HomeMedules(),
    const CategoryMedules(),
    const FavoriteMedules(),
    SettingsMedules(),
  ];

  void changeBottom({required int index}) {
    currentIndex = index;
    emit(StorChangeBottomNavlState());
  }

  HomeModel? model;
  Map<int, bool> isFavorit = {};
  void getProdect() {
    emit(HomeLodingState());
    DioHelper.getData(url: home, token: token).then((value) {
      log(token.toString());
      model = HomeModel.fromJson(value.data);
      for (var e in model!.data!.products) {
        isFavorit.addAll({e.id!: e.inFavorites!});
      }
      log(isFavorit.toString());
      emit(HomeScassesState());
    }).catchError((e) {
      log(e.toString());
      emit(HomeErrorState(e.toString()));
    });
  }

  CategoryModel? cModel;
  void getCategory() {
    emit(CategoryLodingState());
    DioHelper.getData(url: categories).then((value) {
      cModel = CategoryModel.feomJson(value.data);
      emit(CategoryScassesState());
    }).catchError((e) {
      log(e.toString());
      emit(CategoryErrorState(e.toString()));
    });
  }

  AddFavoriteModel? fmodel;
  void changeFavorit(int id) {
    isFavorit[id] = !isFavorit[id]!;
    log(isFavorit[id].toString());
    emit(ChangeFavoritState());
    DioHelper.postData(
            url: favorit,
            data: {
              "product_id": id,
            },
            token: token)
        .then((value) {
      fmodel = AddFavoriteModel.fromJson(value.data);
      log(value.data.toString());
      if (!fmodel!.status!) {
        isFavorit[id] = !isFavorit[id]!;
      }
      getFavoritProdct();
      emit(ChangeFavoritScassesState(fmodel!));
    }).catchError((onError) {
      isFavorit[id] = !isFavorit[id]!;
      emit(ChangeFavoritErrorState(onError.toString()));
    });
  }

  FavoritesDataModel? fDModel;

  void getFavoritProdct() {
    emit(FavoritProdctLodingState());
    DioHelper.getData(url: favorit, token: token).then((value) {
      fDModel = FavoritesDataModel.fromJson(value.data);
      emit(FavoritProdctScassesState());
    }).catchError((e) {
      emit(FavoritProdctErrorState(e.toString()));
    });
  }

  UserStatusModel? uModel;

  void getProfile() {
    emit(ProfileLodingState());
    DioHelper.getData(url: profile, token: token).then((value) {
      uModel = UserStatusModel.fromJson(value.data);
      emit(ProfileScassesState());
    }).catchError((e) {
      emit(ProfileErrorState(e));
    });
  }

  void upDateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpDateLodingState());
    DioHelper.putData(
            url: updateProfile,
            data: {
              "name": name,
              "phone": phone,
              "email": email,
              "password": "123456",
              "image": ""
            },
            token: token)
        .then((value) {
      uModel = UserStatusModel.fromJson(value.data);
      getProfile();
      log(uModel!.data!.name!);
      emit(UpDateScassesState(model: uModel!));
    }).catchError((e) {
      log(e.toString());
      emit(UpDateErrorState(e.toString()));
    });
  }
}
