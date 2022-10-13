import 'package:firebase_database/firebase_database.dart';

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  ChatMessages(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type});

  Map<String, Object?> toJson() {
    return {
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
      'type': type,
    };
  }

  factory ChatMessages.fromDocument(DataSnapshot snapshot) {
    Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
    String idFrom = value["idFrom"];
    String idTo = value["idTo"];
    String timestamp = value["timestamp"];
    String content = value["content"];
    int type = value["type"];

    return ChatMessages(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }
}
