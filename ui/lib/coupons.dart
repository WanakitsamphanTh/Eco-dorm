import 'package:flutter/material.dart';

class CouponsPage extends StatefulWidget{
    const CouponsPage({super.key});
    @override
    State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage>{
    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: Text('Coupons'),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text('Coupons Page'),
                    ],
                ),
            ),
        );
    }
}