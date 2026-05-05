import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'score.dart';

const url = "";

class LogInPage extends StatefulWidget{
    const LogInPage({super.key});

    @override
    State<LogInPage> createState() => _LogInState();
}

class _LogInState extends State<LogInPage>{

    void _onLogInPressed() {
        http.Request request = http.Request('POST', Uri.parse(url));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ScorePage()),
        );
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(Icons.eco, size: 32, color: Color.fromARGB(255, 110, 223, 24)),
                        Icon(Icons.house_rounded, size: 32, color: Color.fromARGB(255, 110, 223, 24))
                    ],
                ),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text(
                            'Log In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                            ),
                        ),
                        const FractionallySizedBox(
                            widthFactor: 0.8,
                            child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email or Student ID',
                                ),
                            ),
                        ),
                        ElevatedButton(
                            onPressed: _onLogInPressed,
                            child: Text('Log In'),
                        ),
                    ],
                ),
            ),
        );
    }
}