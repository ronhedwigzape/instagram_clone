import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      name: 'Instagram Clone Web', 
      options: DefaultFirebaseOptions.webPlatform
    );
  } else if (Platform.isAndroid) {
    await Firebase.initializeApp(
      name: 'Instagram Clone Android',
      options: DefaultFirebaseOptions.androidPlatform
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp(
      name: 'Instagram Clone IOS', 
      options: DefaultFirebaseOptions.iosPlatform
    );
  } else {
    throw UnsupportedError('Unsupported platform');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout()
      // ),
      home: const LoginScreen(),
    );
  }
}
