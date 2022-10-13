import 'package:firebase_database/firebase_database.dart';

class Team {
  String teamId;
  String founder;
  String teamLBack;
  String teamMidfielder;
  String teamName;
  String teamRBack;
  String teamStoper;
  String teamStriker;
  String teamKeeper;

  Team(
    this.teamId,
    this.founder,
    this.teamLBack,
    this.teamMidfielder,
    this.teamName,
    this.teamRBack,
    this.teamStoper,
    this.teamStriker,
    this.teamKeeper,
  );

  void fromDatabase(DataSnapshot snapshot) {
    Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
    teamId = value["teamId"];
    founder = value["founder"];
    teamLBack = value["teamLBack"];
    teamMidfielder = value["teamMidfielder"];
    teamName = value["teamName"];
    teamRBack = value["teamRBack"];
    teamStoper = value["teamStoper"];
    teamStriker = value["teamStriker"];
    teamKeeper = value["teamKeeper"];
  }
}
