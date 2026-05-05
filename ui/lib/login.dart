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

    final _studentId = TextEditingController();

    @override
    void dispose() {
        _studentId.dispose();
        super.dispose();
    }

    void _onLogInPressed() {
        http.Request request = http.Request('POST', Uri.parse(url+"/login"))
            ..headers['Content-Type'] = 'application/json'
            ..body = '{"student_id": "${_studentId.text}"}';

        var success = false;
        if(success){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ScorePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed. Please try again.')),
          );
        }
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
                        FractionallySizedBox(
                            widthFactor: 0.8,
                            child: TextField(
                                controller: _studentId,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Student ID',
                                ),
                            ),
                        ),
                        ElevatedButton(
                            onPressed: _onLogInPressed,
                            child: SizedBox(
                                width: 100,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Icon(Icons.login),
                                        Text('Log In'),
                                    ],
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}