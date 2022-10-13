import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halisahaapp/components/button.dart';
import 'package:halisahaapp/themes/theme_input_decoration.dart';
import 'package:halisahaapp/widgets/card_widget.dart';
import 'package:intl/intl.dart';

import 'login_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Initial Selected Value
  String dropdownvalue = 'forward';

  // List of items in our dropdown menu
  var items = [
    'forward',
    'midfielder',
    'left back',
    'right back',
    'defender',
    'keeper',
  ];
  final formKey = GlobalKey<FormState>();
  DateTime? _pickedDate;
  final TextEditingController _passwordController = TextEditingController(),
      _passwordVerifyController = TextEditingController();
  final TextEditingController _dateInputController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  DateTime datetime = DateTime.now();
  String formattedDate = '';
  String email = '';
  String password = '';
  String fullName = '';
  bool obscurePassword = true, obscureVerifyPassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordVerifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
        title: const Text("HalisahaApp"),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 36),
                    TextFormField(
                      autofillHints: const [AutofillHints.name],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      maxLength: 70,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your full name";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        fullName = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your full name',
                        labelText: 'Full name',
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                      ),
                      keyboardAppearance: Brightness.dark,
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      autofillHints: const [AutofillHints.email],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value.trim();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email address";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your email address',
                        labelText: 'Email address',
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                      ),
                      keyboardAppearance: Brightness.dark,
                    ),
                    const SizedBox(height: 18),
                    DropdownButtonFormField(
                      // Initial Value
                      value: dropdownvalue,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _dateInputController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.done,
                      decoration:
                          const ThemeInputDecoration.borderNone().copyWith(
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                        ),
                        hintText: 'Enter your date of birth',
                        labelText: 'Date of Birth'.toUpperCase(),
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime now = DateTime.now();
                        _pickedDate = await showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.input,
                          initialDate: _pickedDate ?? now,
                          firstDate: DateTime(now.year - 200),
                          lastDate: now,
                        );

                        if (_pickedDate != null) {
                          formattedDate = DateFormat.yMd().format(_pickedDate!);
                          setState(() {
                            _dateInputController.text = formattedDate
                                .toString(); //set output date to TextField value.
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      autofillHints: const [AutofillHints.newPassword],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordController,
                      obscureText: obscurePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please type your password";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Choose your password',
                        labelText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            }
                          },
                          child: Icon(
                            obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      keyboardAppearance: Brightness.dark,
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 4,
                            right: 4,
                            top: 12,
                          ),
                          child: Text(
                            "Password should be at least 6 characters.",
                            style: TextStyle(color: Color(0x61ffffff)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      autofillHints: const [AutofillHints.newPassword],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordVerifyController,
                      obscureText: obscureVerifyPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please type your password again";
                        } else if (value != password) {
                          return "Your password does not match";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Type password again',
                        labelText: 'Confirm password',
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                obscureVerifyPassword = !obscureVerifyPassword;
                              });
                            }
                          },
                          child: Icon(
                            obscureVerifyPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      keyboardAppearance: Brightness.dark,
                    ),
                    const SizedBox(height: 36),
                    isLoading
                        ? const CircularProgressIndicator()
                        : LoginSignupButton(
                            text: 'Register',
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (formKey.currentState!.validate()) {
                                await _signUp();
                              }
                              _passwordController.clear();
                              _passwordVerifyController.clear();
                              setState(() {
                                isLoading = false;
                              });
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _auth.currentUser!.updateDisplayName(fullName);
      String userId = _auth.currentUser!.uid;
      FirebaseDatabase.instance.reference().child("Users/$userId").set({
        'id': userId,
        'fullName': fullName,
        'emailAddress': email,
        'about': 'about you',
        'position': dropdownvalue,
        'birthday': formattedDate.toString(),
        'hasTeam': false,
      });
      CardWidgets.sweetAlert(context, mounted, "Successfully registered.");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = 'Ops! Registration Failed';
      }
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(message),
          content: Text('${e.message}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ops! Registration Failed'),
          content: Text('$e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }
  }
}
