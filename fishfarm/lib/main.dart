import 'package:firebase_core/firebase_core.dart';
import 'package:fishfarm/screens/homepage.dart';
import 'package:fishfarm/screens/login_screen.dart';
import 'package:fishfarm/screens/navigation.dart';
import 'package:fishfarm/screens/recommend_fish.dart';
import 'package:fishfarm/screens/register_screen.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Aquaculture',
      theme: ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/register': (context) => const Register(),
        '/nav': (context) => const ButtomNavigation(
              key: Key('nav'),
            ),
        '/home': (context) => const Home(
              key: Key('home'),
              title: 'Home',
            ),
        '/recommendor': (context) => const FishRecommendor(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
