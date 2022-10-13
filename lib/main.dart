import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halisahaapp/constants/app_constants.dart';
import 'package:halisahaapp/constants/theme_colors.dart';
import 'package:halisahaapp/pages/authentication/login_page.dart';

part 'package:halisahaapp/themes/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3F',
      theme: _themeData,
      home: const LoginScreen(),
    );
  }
}
