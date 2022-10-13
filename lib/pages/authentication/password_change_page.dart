import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halisahaapp/components/button.dart';
import 'package:halisahaapp/models/current_user.dart';

class PasswordChangeScreen extends StatefulWidget {
  final CurrentUser user;

  const PasswordChangeScreen(this.user, {Key? key}) : super(key: key);

  @override
  _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
          TextEditingController(),
      _passwordController = TextEditingController(),
      _passwordVerifyController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  late AuthCredential cred = EmailAuthProvider.credential(
    email: user!.email!,
    password: password,
  );
  late String userName = widget.user.fullName;
  late String emailAddress = widget.user.emailAddress;
  String password = "", newPassword = "";
  bool obscurePassword = true,
      obscureNewPassword = true,
      obscureVerifyPassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
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
        title: const Text("Change password"),
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
                    Column(
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          emailAddress,
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    TextFormField(
                      autofillHints: const [AutofillHints.password],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _currentPasswordController,
                      obscureText: obscurePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please type current password";
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Your current password',
                        labelText: 'Current password',
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
                    const SizedBox(height: 18),
                    TextFormField(
                      autofillHints: const [AutofillHints.newPassword],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordController,
                      obscureText: obscureNewPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please type your new password";
                        }
                      },
                      onChanged: (value) {
                        newPassword = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Choose your new password',
                        labelText: 'New password',
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                obscureNewPassword = !obscureNewPassword;
                              });
                            }
                          },
                          child: Icon(
                            obscureNewPassword
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
                          return "Please type your new password again";
                        } else if (value != newPassword) {
                          return "Your password does not match";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Type new password again',
                        labelText: 'Confirm new password',
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
                            text: 'Update Password',
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (formKey.currentState!.validate()) {
                                await _changePassword();
                              }
                              _currentPasswordController.clear();
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

  Future<void> _changePassword() async {
    await user!.reauthenticateWithCredential(cred).then((_) async {
      try {
        await user!.updatePassword(newPassword);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'wrong-password') {
          message = 'The current password provided is wrong.';
        } else {
          message = 'Ops! Password cannot changed';
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(message),
            content: Text('${e.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Ops! Password cannot changed'),
            content: Text('$e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        );
      }
    }).catchError((err) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Ops! Password is not correct"),
          content: Text('${err.message}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    });
  }
}
