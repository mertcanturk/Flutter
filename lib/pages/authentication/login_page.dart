import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halisahaapp/components/button.dart';
import 'package:halisahaapp/pages/authentication/password_reset_page.dart';
import 'package:halisahaapp/pages/authentication/register_page.dart';
import 'package:halisahaapp/pages/main_pages/main_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late StreamSubscription _authState;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool obscurePassword = true;
  bool isReady = false;
  bool isLoading = false;

  @override
  void initState() {
    _authState = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          isReady = true;
        });
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _authState.cancel();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: isReady
              ? Form(
                  key: formKey,
                  child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle.dark,
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Padding(
                            padding: const EdgeInsets.all(36),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "3F",
                                        style: TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 36),
                                      TextFormField(
                                        autofillHints: const [
                                          AutofillHints.email
                                        ],
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                          hintText: 'Email address',
                                          labelText: 'Email address',
                                          prefixIcon: Icon(
                                            Icons.email,
                                          ),
                                        ),
                                        keyboardAppearance: Brightness.dark,
                                      ),
                                      const SizedBox(height: 18),
                                      TextFormField(
                                        autofillHints: const [
                                          AutofillHints.password
                                        ],
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
                                          hintText: 'Password',
                                          labelText: 'Password',
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              if (mounted) {
                                                setState(() {
                                                  obscurePassword =
                                                      !obscurePassword;
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
                                      const SizedBox(height: 36),
                                      isLoading
                                          ? const CircularProgressIndicator()
                                          : LoginSignupButton(
                                              text: 'Log In',
                                              onTap: () async {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  await _signIn();
                                                }
                                                _passwordController.clear();
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              },
                                            ),
                                      const SizedBox(height: 18),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PasswordResetScreen(email),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Forgot password?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 56),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account yet?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: Icon(Icons.arrow_right_alt),
                                      ),
                                      const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        isReady = false;
      });
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else {
        message = 'Ops! Login Failed';
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
            )
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ops! Login Failed'),
          content: Text('$e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }
  }
}
