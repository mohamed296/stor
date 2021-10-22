import 'package:stor/model/add_favorites_model.dart';
import 'package:stor/model/user_model.dart';

abstract class StorState {}

class StorInatioalState extends StorState {}

class StorChangeBottomNavlState extends StorState {}

class HomeLodingState extends StorState {}

class HomeScassesState extends StorState {
  // UserStatusModel userModel;
  // LoginScassesState({
  //   required this.userModel,
  // });
}

class HomeErrorState extends StorState {
  final String error;
  HomeErrorState(this.error);
}

class CategoryLodingState extends StorState {}

class CategoryScassesState extends StorState {}

class CategoryErrorState extends StorState {
  final String error;
  CategoryErrorState(this.error);
}

class ChangeFavoritState extends StorState {}

class ChangeFavoritScassesState extends StorState {
  final AddFavoriteModel model;

  ChangeFavoritScassesState(this.model);
}

class ChangeFavoritErrorState extends StorState {
  final String error;
  ChangeFavoritErrorState(this.error);
}

class FavoritProdctLodingState extends StorState {}

class FavoritProdctScassesState extends StorState {}

class FavoritProdctErrorState extends StorState {
  final String error;
  FavoritProdctErrorState(this.error);
}

class ProfileLodingState extends StorState {}

class ProfileScassesState extends StorState {}

class ProfileErrorState extends StorState {
  final String error;
  ProfileErrorState(this.error);
}

class UpDateLodingState extends StorState {}

class UpDateScassesState extends StorState {
  UserStatusModel model;
  UpDateScassesState({
    required this.model,
  });
}

class UpDateErrorState extends StorState {
  final String error;
  UpDateErrorState(this.error);
}
