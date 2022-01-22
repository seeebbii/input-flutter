class AuthModel {
  String? userId;
  String? name;
  String? secret;
  String? ipAddress;
  String? userCreatedAt;

  AuthModel({
    this.userId,
    this.name,
    this.secret,
    this.ipAddress,
    this.userCreatedAt,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    name = json['name'];
    secret = json['secret'];
    ipAddress = json['ipAddress'];
    userCreatedAt = json['userCreatedAt'];
  }

  Map<String, dynamic> toJson() => {
        '_id': userId,
        'name': name,
        'secret': secret,
        'ipAddress': ipAddress,
        'userCreatedAt': userCreatedAt,
      };

  factory AuthModel.emptyAuth() => AuthModel(userId: "", name: "", secret: "", ipAddress: "", userCreatedAt: "");

}
