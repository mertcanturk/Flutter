import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:halisahaapp/models/notifications.dart';
import 'package:halisahaapp/widgets/card_widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _auth = FirebaseAuth.instance;
  late String userId = _auth.currentUser!.uid;
  List<Notifications> notificationList = [];

  bool isReady = false;

  late DatabaseReference databaseReferenceNotifications =
      FirebaseDatabase.instance.reference().child("Notifications/$userId");

  late StreamSubscription _notificationsStream;

  Future<void> transferRequest(
    String playerName,
    String teamId,
    String position,
    int type,
  ) async {
    String realPos = '';
    position = position.toLowerCase();
    if (position == 'forward') {
      realPos = 'teamStriker';
    } else if (position == 'defender') {
      realPos = 'teamStoper';
    } else if (position == 'midfielder') {
      realPos = 'teamMidfielder';
    } else if (position == 'left back') {
      realPos = 'teamLBack';
    } else if (position == 'right back') {
      realPos = 'teamRBack';
    } else {
      realPos = 'teamKeeper';
    }

    try {
      FirebaseDatabase.instance.reference().child("Teams/$teamId").update(
          {realPos: type == 0 ? _auth.currentUser?.displayName : playerName});
      CardWidgets.sweetAlert(context, mounted, "Successfully transferred.");
    } catch (e) {
      CardWidgets.sweetAlert(context, mounted, "Error transferring.");
    }
  }

  void getAllNotifications() {
    notificationList.clear();

    _notificationsStream =
        databaseReferenceNotifications.onValue.listen((event) {
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
        value.forEach((key, response) {
          if (response["state"] == 1) {
            notificationList.add(Notifications(
              response["teamId"],
              response["teamName"],
              response["message"],
              response["position"],
              response["playerName"],
              response["type"],
              response["state"],
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
    _notificationsStream.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    getAllNotifications();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Text("All Invites"),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            notificationList[index].type == 0
                                ? notificationList[index].teamName
                                : notificationList[index].playerName,
                            style: Theme.of(context).textTheme.button,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            notificationList[index].message,
                            style: Theme.of(context).textTheme.button,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    transferRequest(
                                        notificationList[index].playerName,
                                        notificationList[index].teamId,
                                        notificationList[index].position,
                                        notificationList[index].type);
                                  },
                                  child: const Text("Accept")),
                              ElevatedButton(
                                  onPressed: () {
                                    CardWidgets.sweetAlert(
                                        context, mounted, "Transfer Rejected");
                                  },
                                  child: const Text("Reject"))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: notificationList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
