import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class CurrentUser {
  String id;
  String fullName;
  String emailAddress;
  String about;
  String birthday;
  String position;
  bool hasTeam;

  CurrentUser(
    this.id,
    this.fullName,
    this.emailAddress,
    this.about,
    this.birthday,
    this.position,
    this.hasTeam,
  );

  void fromAuth(User user) {
    fullName = user.displayName ?? "";
    emailAddress = user.email ?? "";
  }

  void fromDatabase(DataSnapshot snapshot) {
    Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
    id = value["id"];
    emailAddress = value["emailAddress"];
    birthday = value["birthday"];
    about = value["about"];
    position = value["position"];
    hasTeam = value["hasTeam"];
  }
}
