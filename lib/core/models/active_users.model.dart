class ActiveUsersModel {
  String? userId;
  String? name;
  String? socketId;

  ActiveUsersModel({this.userId, this.name, this.socketId});

  ActiveUsersModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    socketId = json['socketId'];
  }

  Map<String, dynamic> toJson() => {'userId': userId, 'name': name, "socketId": socketId};
}
