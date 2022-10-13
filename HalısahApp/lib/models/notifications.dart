import 'package:firebase_database/firebase_database.dart';

class Notifications {
  String teamId;
  String teamName;
  String message;
  String position;
  String playerName;
  int type;
  int state;

  Notifications(
    this.teamId,
    this.teamName,
    this.message,
    this.position,
    this.playerName,
    this.type,
    this.state,
  );

  void fromDatabase(DataSnapshot snapshot) {
    Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
    teamId = value["teamId"];
    teamName = value["teamName"];
    message = value["message"];
    position = value["position"];
    playerName = value["playerName"];
    type = value["type"];
    state = value["state"];
  }
}
