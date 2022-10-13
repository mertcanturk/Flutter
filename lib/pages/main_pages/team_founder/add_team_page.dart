import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:halisahaapp/extensions/flex_extensions.dart';
import 'package:halisahaapp/pages/authentication/login_page.dart';
import 'package:halisahaapp/pages/main_pages/player/notifications_page.dart';
import 'package:halisahaapp/pages/main_pages/profile_page.dart';
import 'package:halisahaapp/pages/main_pages/team_founder/find_player.dart';

class AddTeamPage extends StatefulWidget {
  const AddTeamPage({Key? key}) : super(key: key);

  @override
  State<AddTeamPage> createState() => _AddTeamPageState();
}

class _AddTeamPageState extends State<AddTeamPage> {
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  late String randomuuid = getRandomString(15);

  int playerCount = 0;
  String teamId = "";
  String teamName = "";
  final _auth = FirebaseAuth.instance;
  late String userId = _auth.currentUser!.uid;
  bool isReady = false;
  bool isLoading = false;
  late DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("Teams/");
  late StreamSubscription _teamStream;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _teamName = TextEditingController();
  final TextEditingController _teamStoper = TextEditingController();
  final TextEditingController _teamRBack = TextEditingController();
  final TextEditingController _teamLBack = TextEditingController();
  final TextEditingController _teamMidfielder = TextEditingController();
  final TextEditingController _teamStriker = TextEditingController();
  final TextEditingController _teamKeeper = TextEditingController();

  int countPlayers() {
    int playerCount = 0;
    if (_teamStoper.text.toString().trim().isNotEmpty) {
      playerCount++;
    }
    if (_teamMidfielder.text.toString().trim().isNotEmpty) {
      playerCount++;
    }
    if (_teamRBack.text.toString().trim().isNotEmpty) {
      playerCount++;
    }
    if (_teamLBack.text.toString().trim().isNotEmpty) {
      playerCount++;
    }
    if (_teamStriker.text.toString().trim().isNotEmpty) {
      playerCount++;
    }
    return playerCount;
  }

  void getTeam() {
    _teamStream = databaseReference.onValue.listen((event) {
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
        value.forEach((key, response) {
          response as Map<dynamic, dynamic>;
          if (response["founder"] == userId) {
            teamId = response["teamId"];
            teamName = response["teamName"];
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

  Future<void> addTeam() async {
    if (_formKey.currentState!.validate()) {
      await databaseReference.child(randomuuid).set({
        "teamId": randomuuid,
        "teamName": _teamName.text,
        "teamStoper": _teamStoper.text.toString().trim().isNotEmpty
            ? _teamStoper.text.toString().trim()
            : "bos",
        "teamRBack": _teamRBack.text.toString().trim().isNotEmpty
            ? _teamRBack.text.toString().trim()
            : "bos",
        "teamLBack": _teamLBack.text.toString().trim().isNotEmpty
            ? _teamLBack.text.toString().trim()
            : "bos",
        "teamMidfielder": _teamMidfielder.text.toString().trim().isNotEmpty
            ? _teamMidfielder.text.toString().trim()
            : "bos",
        "teamStriker": _teamStriker.text.toString().trim().isNotEmpty
            ? _teamStriker.text.toString().trim()
            : "bos",
        "teamKeeper": _teamKeeper.text.toString().trim().isNotEmpty
            ? _teamKeeper.text.toString().trim()
            : "bos",
        "playerCount": playerCount.toString(),
        "askingCount": (5 - playerCount).toString(),
        "founder": userId,
      });
      Navigator.pop(context);
    }
  }

  Future<void> handleClick(String value) async {
    switch (value) {
      case 'Logout':
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        break;
      case 'Invite Players':
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FindPlayer(
                  teamId: teamId,
                  teamName: teamName,
                )));
        break;
      case 'Profile':
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
      case 'Notifications':
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NotificationsPage()));
        break;
    }
  }

  @override
  void dispose() {
    _teamName.dispose();
    _teamRBack.dispose();
    _teamStoper.dispose();
    _teamStriker.dispose();
    _teamMidfielder.dispose();
    _teamLBack.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getTeam();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Team'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Invite Players', 'Profile', 'Notifications'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            isReady = _teamName.text.isNotEmpty;
          });
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _teamName,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'fill here',
                          labelText: 'Team Name'.toUpperCase(),
                        ),
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _teamStoper,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'fill here',
                          labelText: 'Stoper'.toUpperCase(),
                        ),
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _teamLBack,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'fill here',
                          labelText: 'Left Back'.toUpperCase(),
                        ),
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _teamRBack,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'fill here',
                          labelText: 'Right Back'.toUpperCase(),
                        ),
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _teamStriker,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'fill here',
                          labelText: 'Striker'.toUpperCase(),
                        ),
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _teamMidfielder,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'fill here',
                          labelText: 'Midfielder'.toUpperCase(),
                        ),
                      ),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _teamKeeper,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'fill here',
                          labelText: 'GoalKeeper'.toUpperCase(),
                        ),
                      ),
                    ],
                  ).separated(const SizedBox(
                    height: 16.0,
                  )),
                ),
                Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () async {
                          playerCount = countPlayers();
                          setState(() {
                            isLoading = true;
                          });
                          await addTeam();
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: const Text('Add'))),
                isLoading
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(),
              ],
            ).separated(
              const SizedBox(
                height: 16.0,
              ),
            ),
          ),
        ),
      )),
    );
  }
}
