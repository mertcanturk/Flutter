import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:halisahaapp/constants/theme_colors.dart';
import 'package:halisahaapp/extensions/flex_extensions.dart';
import 'package:halisahaapp/models/current_user.dart';
import 'package:halisahaapp/pages/authentication/password_change_page.dart';
import 'package:halisahaapp/themes/theme_button_style.dart';
import 'package:halisahaapp/themes/theme_input_decoration.dart';
import 'package:halisahaapp/widgets/card_widget.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime? _pickedDate;
  DateTime datetime = DateTime.now();
  String formattedDate = '';
  bool isReady = false;
  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _birthDateController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _anouncementController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String userId = _auth.currentUser!.uid;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  late DatabaseReference databaseReferenceUsers =
      _database.child("Users/$userId");
  late Reference storageReference =
      FirebaseStorage.instance.ref('images/avatars').child(userId);
  late CurrentUser user = CurrentUser(
      "id", "fullName", "emailAddress", "about", "birthday", "position", false);
  late StreamSubscription _authStream, _userStream;

  Future<void> updateProfile() async {
    try {
      FirebaseDatabase.instance.reference().child("Users/$userId").update({
        'fullName': _fullNameController.text.isNotEmpty
            ? _fullNameController.text
            : _auth.currentUser!.displayName,
        'emailAddress': _auth.currentUser!.email,
        'about': _anouncementController.text.isNotEmpty
            ? _anouncementController.text
            : user.about,
        'birthday': _birthDateController.text,
      });
      CardWidgets.sweetAlert(context, mounted, "Successfully updated.");
    } catch (e) {
      CardWidgets.sweetAlert(context, mounted, "Error updating profile.");
    }
  }

  void profileFirebase() {
    _authStream = _auth.userChanges().listen((User? user) {
      if (user != null) {
        this.user.fromAuth(user);
        if (mounted) {
          setState(() {});
        }
      }
    });
    _userStream = databaseReferenceUsers.onValue.listen((event) {
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.exists) {
        user.fromDatabase(snapshot);
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    profileFirebase();
    super.initState();
  }

  @override
  void dispose() {
    _authStream.cancel();
    _userStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0, //No shadow
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          onChanged: () {
            setState(() {
              isReady = true;
            });
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            user.position,
                            style: TextStyle(
                              color: ThemeColors.slate.shade400,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Chip(
                  label: Text(
                    user.emailAddress,
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColors.indigo.shade50,
                    ),
                  ),
                  backgroundColor: ThemeColors.indigo.shade900,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _birthDateController,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.done,
                        decoration:
                            const ThemeInputDecoration.borderNone().copyWith(
                          prefixIcon: const Icon(
                            Icons.calendar_today,
                          ),
                          hintText: user.birthday,
                          labelText: 'Date of Birth'.toUpperCase(),
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime now = DateTime.now();
                          _pickedDate = await showDatePicker(
                            context: context,
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light(),
                                child: Container(child: child),
                              );
                            },
                            initialEntryMode: DatePickerEntryMode.input,
                            initialDate: _pickedDate ?? now,
                            firstDate: DateTime(now.year - 200),
                            lastDate: now,
                          );

                          if (_pickedDate != null) {
                            formattedDate =
                                DateFormat.yMd().format(_pickedDate!);
                            setState(() {
                              _birthDateController.text = formattedDate
                                  .toString(); //set output date to TextField value.
                            });
                          }
                        },
                      ),
                      TextFormField(
                        controller: _fullNameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: user.fullName,
                          labelText: 'Full Name'.toUpperCase(),
                        ),
                      ),
                      TextFormField(
                        maxLines: 5,
                        minLines: 1,
                        controller: _anouncementController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: user.about,
                          labelText: 'About'.toUpperCase(),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PasswordChangeScreen(user),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock,
                                color: ThemeColors.blue.withOpacity(.87),
                                size: 26.0,
                              ),
                              const SizedBox(width: 12.0),
                              const Text(
                                "Change password",
                                style: TextStyle(color: ThemeColors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        child: Text(
                          'Update',
                          style: Theme.of(context).textTheme.button,
                        ),
                        onPressed: isReady
                            ? () async {
                                setState(() {
                                  isLoading = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  await updateProfile();
                                }

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            : null,
                        style: ThemeButtonStyle.large(),
                      ),
                    ],
                  ).separated(
                    const SizedBox(
                      height: 12.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
