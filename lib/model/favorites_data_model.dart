class FavoritesDataModel {
  bool? status;
  FavoritData? data;
  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    status = json['id'];
    data = FavoritData.fromJson(json['data']);
  }
}

class FavoritData {
  int? currentPage;
  List<Data> data = [];
  FavoritData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  int? id;
  ProductData? product;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductData.fromJson(json['product']);
  }
}

class ProductData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  String? image;
  String? name;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    image = json['image'];
    name = json['name'];
  }
}
