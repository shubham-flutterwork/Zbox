import 'package:flutter/material.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {


  Widget _dashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("WELCOME BACK",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                          height: 1.3,
                        )),
                    Text("Jack Doeson",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1.3,
                        )),
                  ]
              ),
              Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/img/user.jpg'),
              )
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 320,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCard("Active Projects", "23", "↑ 3 More in last 7 days", Colors.green),
                _buildCard("Overdue", "12", "↓ 1 Less in last 7 days", Colors.red),
                _buildCard("Pending", "35", "↑ 1 New in last 7 days", Colors.orange),
                _buildCard("Meetings", "None", "No Live Meetings", Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text("YOUR PROJECTS", style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text("View All"))
            ],
          ),
          _buildProjectItem("Website Launch", "Developing", 2, 6, Colors.blue),
          _buildProjectItem("Application Update", "Complete", 10, 10, Colors.green),
          _buildProjectItem("Server Data Transfer", "Canceled", 3, 5, Colors.red),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String value, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildProjectItem(String name, String status, int done, int total, Color color) {
    double progress = total == 0 ? 0 : done / total;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: color, radius: 18),
              const SizedBox(width: 12),
              Expanded(
                child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Text("$done/$total", style: const TextStyle(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 6),
          Text(status, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            color: color,
            backgroundColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: _dashboardContent(),
    );
  }
}
