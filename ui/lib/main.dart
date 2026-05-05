import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'score.dart';
import 'coupons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Color.fromARGB(255, 110, 223, 24)),
      ),
      home: const AppPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({super.key, required this.title});

  final String title;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {

  var _loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loggedIn ? ScorePage() : LogInPage(),
        ),
      );
  }
}
