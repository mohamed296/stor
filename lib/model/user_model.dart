class UserStatusModel {
  bool? status;
  String? message;
  UserDataModel? data;
  UserStatusModel({
    required this.status,
    required this.message,
    required this.data,
  });
  // factory UserStatusModel.fromRewJson(String str) =>
  //     UserStatusModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  UserStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDataModel.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //       "message": message,
  //       "data": data!.toJson(),
  //     };
}

class UserDataModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? points;
  int? credit;
  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.token,
    required this.points,
    required this.credit,
  });
  // factory UserDataModel.fromRawJson(String str) =>
  //     UserDataModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    email = json['email'] as String;
    phone = json['phone'] as String;
    image = json['image'] as String;
    token = json['token'] as String;
    points = json['points'] as int;
    credit = json['credit'] as int;
  }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "email": email,
  //       "phone": phone,
  //       "image": image,
  //       "points": points,
  //       "credit": credit,
  //       "token": token,
  //     };
}
