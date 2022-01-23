class ActiveUsersModel {
  String? userId;
  String? name;

  ActiveUsersModel({this.userId, this.name});

  ActiveUsersModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {'userId': userId, 'name': name};
}
