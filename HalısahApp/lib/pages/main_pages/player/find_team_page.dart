import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:halisahaapp/models/team.dart';
import 'package:halisahaapp/pages/main_pages/player/notifications_page.dart';
import 'package:halisahaapp/pages/main_pages/player/team_details_page.dart';

class FindTeamPage extends StatefulWidget {
  const FindTeamPage({Key? key}) : super(key: key);

  @override
  State<FindTeamPage> createState() => _FindTeamPageState();
}

class _FindTeamPageState extends State<FindTeamPage> {
  late DatabaseReference databaseReferenceLibrary =
      FirebaseDatabase.instance.reference().child("Teams");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId = _auth.currentUser!.uid;
  late StreamSubscription _commentsStream;
  bool isReady = false;
  List<Team> commentsList = [];

  bool isFull(Team team) {
    if (team.teamStriker != "bos" &&
        team.teamMidfielder != "bos" &&
        team.teamStoper != "bos" &&
        team.teamLBack != "bos" &&
        team.teamRBack != "bos" &&
        team.teamKeeper != "bos") {
      return true;
    } else {
      return false;
    }
  }

  void getAllTeams() {
    _commentsStream = databaseReferenceLibrary.onValue.listen((event) {
      commentsList.clear();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
        value.forEach((key, response) {
          response as Map<dynamic, dynamic>;
          commentsList.add(Team(
            response["teamId"],
            response["founder"],
            response["teamLBack"],
            response["teamMidfielder"],
            response["teamName"],
            response["teamRBack"],
            response["teamStoper"],
            response["teamStriker"],
            response["teamKeeper"],
          ));
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
    _commentsStream.cancel();
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
        title: Text("Find Team"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationsPage()));
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: isReady
          ? SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: commentsList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TeamDetailsPage(
                                    team: commentsList[index],
                                  )));
                        },
                        tileColor: Colors.white,
                        leading: Icon(Icons.sports_baseball),
                        title:
                            Center(child: Text(commentsList[index].teamName)),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people_alt),
                            isFull(commentsList[index])
                                ? Text(
                                    "Full",
                                    style: TextStyle(color: Colors.redAccent),
                                  )
                                : Text(
                                    "Available",
                                    style: TextStyle(color: Colors.greenAccent),
                                  )
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Icon(Icons.sports_baseball),
                      );
                    }),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
