class SearchStatusModel {
  bool? status;
  SearchData? data;
  SearchStatusModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = SearchData.fromJson(json['data']);
  }
}

class SearchData {
  int? currentPage;
  List<Data> data = [];
  SearchData.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    json["data"].forEach((e) {
      data.add(Data.fromJson(e));
    });
  }
}

class Data {
  int? id;
  dynamic price;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
  }
}
