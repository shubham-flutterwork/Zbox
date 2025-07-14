import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dashboard5 extends StatefulWidget {
  const Dashboard5({super.key});

  @override
  State<Dashboard5> createState() => _Dashboard5State();
}

class _Dashboard5State extends State<Dashboard5> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  late Timer _timer;

  final List<Map<String, dynamic>> cards = [
    {
      'color': Colors.blue,
      'name': "GARY SINGH",
      'number': "**** **** ****  0287",
      'brand': "VISA"
    },
    {
      'color': Colors.purple,
      'name': "ANN SINGH",
      'number': "**** **** ****  5864",
      'brand': "HSBC"
    },
    {
      'color': Colors.orange,
      'name': "Jhon Doe",
      'number': "**** **** **** 4638",
      'brand': "MasterCard"
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < cards.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back_outlined,color: Colors.blue,),
                        Column(
                          children: [
                            const Text("Card Details",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                            const SizedBox(height: 4),
                            const Text("Available: \$889",
                                style: TextStyle(fontSize: 14, color: Colors.blue,)),
                          ],
                        ),
                        Icon(Icons.menu,color: Colors.blue,),
                      ],
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          final card = cards[index];
                          return _buildCard(
                            color: card['color'],
                            name: card['name'],
                            number: card['number'],
                            brand: card['brand'],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: cards.length,
                      effect: WormEffect(
                        activeDotColor: Colors.blue,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildTransactionList(),
              const SizedBox(height: 20),
              _buildOptions(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required Color color,
    required String name,
    required String number,
    required String brand,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("MOBILE First Bank", style: TextStyle(color: Colors.white70)),
          Text(number,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("01/22", style: TextStyle(color: Colors.white70)),
                  Text(name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(brand,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recent Transactions",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Icon(Icons.more_horiz),
                ],
              ),
            ),
            const Divider(height: 1),
            Container(
              color: Colors.grey.shade100,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Text("Day", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("Debited", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("Credited", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 1, child: Text("Type", style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ),

            const Divider(height: 1),
            _transactionRow("14", "MON", "\$257", "752",
                Icons.home_outlined, Colors.pink),
            _transactionRow("15", "TUE", "\$790", "728",
                Icons.diamond_outlined, Colors.blue),
            _transactionRow("16", "WED", "\$451", "694",
                Icons.shopping_cart_outlined, Colors.purple),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _optionTile(Icons.credit_card, "Card On/Off"),
          _optionTile(Icons.tune, "Control"),
          _optionTile(Icons.notifications, "Alerts"),
          _optionTile(Icons.group, "Shared Card Users", subtitle: "1 user"),
        ],
      ),
    );
  }

  Widget _optionTile(IconData icon, String title, {String? subtitle}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  static Widget _transactionRow(String day, String date, String debited,
      String credited, IconData icon, Color color) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day,
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12))
        ],
      ),
      title: Row(
        children: [
          Expanded(
              child: Text(debited,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold))),
          Expanded(
              child: Text(credited,
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold))),
        ],
      ),
      trailing: Icon(icon, color: color),
    );
  }
}
