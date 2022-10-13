import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:halisahaapp/constants/theme_colors.dart';
import 'package:halisahaapp/models/team.dart';
import 'package:halisahaapp/widgets/card_widget.dart';

class TeamDetailsPage extends StatefulWidget {
  final Team team;
  const TeamDetailsPage({Key? key, required this.team}) : super(key: key);

  @override
  State<TeamDetailsPage> createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  final _auth = FirebaseAuth.instance;
  late String userId = _auth.currentUser!.uid;
  String position = "";
  bool isReady = false;
  late DatabaseReference databaseReference = FirebaseDatabase.instance
      .reference()
      .child("Notifications")
      .child(widget.team.founder);
  Future<void> senNotifications() async {
    await databaseReference.push().set({
      "teamId": widget.team.teamId,
      "teamName": widget.team.teamName,
      "message": "I want to join your team",
      "position": position,
      "playerName": _auth.currentUser!.displayName,
      "type": 1,
      "state": 1
    });
    if (mounted) {
      setState(() {
        isReady = true;
      });
    }
    Navigator.pop(context);
    CardWidgets.sweetAlert(context, mounted, "Request Sended");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.team.teamName),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.team.teamStriker + " (st)"),
                            Visibility(
                                visible: widget.team.teamStriker == "bos",
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      position = "forward";
                                    });
                                    await senNotifications();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: ThemeColors.red,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.team.teamMidfielder + " (cm)"),
                            Visibility(
                                visible: widget.team.teamMidfielder == "bos",
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      position = "midfielder";
                                    });
                                    await senNotifications();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: ThemeColors.red,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.team.teamLBack + " (lb)"),
                            Visibility(
                                visible: widget.team.teamLBack == "bos",
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      position = "left back";
                                    });
                                    await senNotifications();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: ThemeColors.red,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.team.teamStoper + " (cb)"),
                            Visibility(
                                visible: widget.team.teamStoper == "bos",
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      position = "defender";
                                    });
                                    await senNotifications();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: ThemeColors.red,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.team.teamRBack + " (rb)"),
                            Visibility(
                                visible: widget.team.teamRBack == "bos",
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      position = "right back";
                                    });
                                    await senNotifications();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: ThemeColors.red,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.team.teamKeeper + " (gk)"),
                            Visibility(
                                visible: widget.team.teamKeeper == "bos",
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      position = "teamKeeper";
                                    });
                                    await senNotifications();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: ThemeColors.red,
                                  ),
                                )),
                          ],
                        ),
                      ]),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Chip(
                        label: Text('ST'),
                      ),
                      Chip(
                        label: Text('CM'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Chip(
                            label: Text('LB'),
                          ),
                          Chip(
                            label: Text('CB'),
                          ),
                          Chip(
                            label: Text('RB'),
                          ),
                        ],
                      ),
                      Chip(
                        label: Text('GK'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
