class AddFavoriteModel {
  bool? status;
  String? massges;
  AddFavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    massges = json['message'];
  }
}
