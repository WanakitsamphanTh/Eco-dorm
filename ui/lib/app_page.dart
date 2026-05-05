import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'score.dart';
import 'coupons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'qr_generator.dart';
import 'api_client.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key, required this.apiClient});

  final ApiClient apiClient;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {

    final List<Widget> _pages = List.filled(3, SizedBox());
    int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages[0] = ScorePage(apiClient: widget.apiClient);
    _pages[1] = CouponsPage(apiClient: widget.apiClient);
    _pages[2] = QRPage(apiClient: widget.apiClient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomAppBar(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        IconButton(
                            icon: Icon(Icons.home),
                            onPressed: () {
                                setState(() {
                                    currentIndex = 0;
                                });
                            },
                        ),
                        IconButton(
                            icon: Icon(Icons.wallet_giftcard),
                            onPressed: () {
                                setState(() {
                                    currentIndex = 1;
                                });
                            },
                        ),
                        IconButton(
                            icon: Icon(Icons.qr_code_scanner),
                            onPressed: () {
                                setState(() {
                                    currentIndex = 2;
                                });
                            },
                        ),
                    ],
                ),
            ),
    );
  }
}