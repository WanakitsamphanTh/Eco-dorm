import 'package:flutter/material.dart';
import 'api_client.dart';

class CouponsPage extends StatefulWidget{
    const CouponsPage({super.key, required this.apiClient});
    final ApiClient apiClient;

    @override
    State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage>{

    void _useCoupon(String name) {
        return;
    }

    Widget createCoupons(String name, String expiry){
        return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(name),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _useCoupon(name);
                      },
                      child: const Text("Use this coupon"),
                    ),
                  ],
                ),
              );
            },
            child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 233, 251, 218),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                    )
                ],
            ),
            child: Column(
                children: [
                    Text(
                        name,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                        ),
                    ),
                    SizedBox(height: 8),
                    Text(
                        'Expires on $expiry',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.green.shade600,
                        ),
                    ),
                ],
            ),
        )
        );
    }

    List<Widget> getCoupons() {
        // var coupons = widget.apiClient.getCoupons();
        var coupons = [
            {"name": "10% Off Eco-Friendly Products", "expiry": "2024-12-31"},
            {"name": "Free Shipping on Orders Over \$50", "expiry": "2024-11-30"},
            {"name": "\$5 Off Your Next Purchase", "expiry": "2024-10-15"},
        ];

        return coupons.map((e) => createCoupons(e["name"]!, e["expiry"]!)).toList();
    }
    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
            title: const Text("Coupons"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.green,
          ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: getCoupons()
                ),
            ),
        );
    }
}