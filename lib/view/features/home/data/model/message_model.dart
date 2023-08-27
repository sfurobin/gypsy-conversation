class MessageModel {
  int? id;
  String? name;
  String? photo;
  bool? isActive;
  String? lastMessage;
  String? message;
  String? time;
  bool? seen;
  int? count;
  bool? isMe;

  MessageModel(
      {this.id,
        this.name,
        this.photo,
        this.isActive,
        this.lastMessage,
        this.message,
        this.time,
        this.seen,
        this.count,
      this.isMe});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    isActive = json['isActive'];
    lastMessage = json['lastMessage'];
    message = json['message'];
    time = json['time'];
    seen = json['seen'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['isActive'] = isActive;
    data['lastMessage'] = lastMessage;
    data['message'] = message;
    data['time'] = time;
    data['seen'] = seen;
    data['count'] = count;
    return data;
  }
}
