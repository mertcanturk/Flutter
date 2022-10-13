import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:halisahaapp/constants/theme_colors.dart';
import 'package:halisahaapp/pages/authentication/login_page.dart';
import 'package:halisahaapp/pages/main_pages/player/find_team_page.dart';
import 'package:halisahaapp/pages/main_pages/player/notifications_page.dart';
import 'package:halisahaapp/pages/main_pages/player/team_details_page.dart';
import 'package:halisahaapp/pages/main_pages/profile_page.dart';
import 'package:halisahaapp/pages/main_pages/team_founder/add_team_page.dart';

import '../../models/team.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late DatabaseReference databaseReferenceLibrary =
      FirebaseDatabase.instance.reference().child("Teams");
  late StreamSubscription _commentsStream;
  late String userId = _auth.currentUser!.uid;
  List<Team> commentsList = [];
  final _auth = FirebaseAuth.instance;
  late StreamSubscription _authStream;
  Future<void> _signOut() async {
    _authStream.cancel();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("3F"),
        centerTitle: true,
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
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 350,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const FindTeamPage())));
                    },
                    child: const Text("Find a Team")),
              ),
              Container(
                height: 100,
                width: 350,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: ThemeColors.white,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const AddTeamPage())));
                    },
                    child: const Text("Create a Team")),
              ),
              Container(
                height: 100,
                width: 350,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: ThemeColors.white,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const ProfileScreen())));
                    },
                    child: const Text("Profile")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
