class CategoryModel {
  bool? status;
  CategoryDataModel? data;
  CategoryModel.feomJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromJon(json['data']);
  }
}

class CategoryDataModel {
  int? currentPage;
  List<DataModel> data = [];
  CategoryDataModel.fromJon(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((e) {
      data.add(DataModel.fromJson(e));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
