import 'package:flutter/material.dart';
import 'login.dart';
import 'api_client.dart';

const url = "172.31.0.81";

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
      home: LogInPage(apiClient: ApiClient(url)),
    );
  }
}
