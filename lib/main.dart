import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.webPlatform);
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout()
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            } 
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } 
            return const LoginScreen();
          }
        ),
      ),
    );
  }
}
