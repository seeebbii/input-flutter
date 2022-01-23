class ChatModel {
  String? messageId;
  String? userId;
  String? name;
  String? message;
  DateTime? sentDate;

  ChatModel(
      {this.messageId, this.userId, this.name, this.message, this.sentDate});

  ChatModel.fromJson(Map<String, dynamic> json) {
    messageId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    message = json['message'];
    sentDate = DateTime.parse(json['sentDate']);
  }

  Map<String, dynamic> toJson() => {
        'messageId': messageId,
        'userId': userId,
        'name': name,
        'message': message,
        'sentDate': sentDate?.toIso8601String(),
      };
}
