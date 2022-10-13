import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:halisahaapp/models/current_user.dart';
import 'package:halisahaapp/pages/main_pages/team_founder/inspect_profile.dart';

class FindPlayer extends StatefulWidget {
  final String teamId, teamName;
  const FindPlayer({required this.teamId, required this.teamName, Key? key})
      : super(key: key);

  @override
  State<FindPlayer> createState() => _FindPlayerState();
}

class _FindPlayerState extends State<FindPlayer> {
  late DatabaseReference databaseReferenceUsers =
      FirebaseDatabase.instance.reference().child("Users");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId = _auth.currentUser!.uid;
  late StreamSubscription _userStream;
  bool isReady = false;
  List<CurrentUser> playersList = [];

  void getAllTeams() {
    _userStream = databaseReferenceUsers.onValue.listen((event) {
      playersList.clear();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
        value.forEach((key, response) {
          response as Map<dynamic, dynamic>;
          if (response["id"] != userId) {
            playersList.add(CurrentUser(
              response["id"],
              response["fullName"],
              response["emailAddress"],
              response["about"],
              response["birthday"],
              response["position"],
              response["hasTeam"],
            ));
          }
        });
      }
      if (mounted) {
        setState(() {
          isReady = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _userStream.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    getAllTeams();
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Team"),
      ),
      body: isReady
          ? SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: playersList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: Colors.white,
                        leading: const Icon(Icons.sports_baseball),
                        title: Center(child: Text(playersList[index].fullName)),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.people_alt),
                            Text(playersList[index].position),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: const Icon(Icons.sports_baseball),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => InspectProfilePage(
                                    currentUser: playersList[index],
                                    teamId: widget.teamId,
                                    teamName: widget.teamName)),
                          );
                        },
                      );
                    }),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
