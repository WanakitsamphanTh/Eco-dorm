import 'package:flutter/material.dart';

class ScorePage extends StatefulWidget{
    const ScorePage({super.key});

    @override
    State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage>{
    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: Text('Score'),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text('Score Page'),
                    ],
                ),
            ),
        );
    }
}