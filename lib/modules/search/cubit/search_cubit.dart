import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/model/search_model.dart';
import 'package:stor/modules/search/cubit/search_state.dart';
import 'package:stor/shared/service/network/dio_helper.dart';
import 'package:stor/shared/service/network/end_boint.dart';
import 'package:stor/shared/widget/constante.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchStatusModel? model;
  void searchForProdect({required String text}) {
    emit(SearchLodingState());
    DioHelper.postData(url: productsSearch, data: {"text": text}, token: token)
        .then((value) {
      model = SearchStatusModel.fromJson(value.data);
      log("Search Scasses...");
      emit(SearchScsessState());
    }).catchError((e) {
      log(e.toString());
      emit(SearchErrorState(error: e.toString()));
    });
  }
}
