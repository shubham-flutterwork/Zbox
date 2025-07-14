import 'package:flutter/material.dart';

class Dashboard3 extends StatelessWidget {
  const Dashboard3({super.key});

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String changeText,
    required IconData icon,
    required Color iconColor,
    required Color changeColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor, size: 18),
                radius: 14,
              ),
              const Spacer(),
              Text(
                changeText,
                style: TextStyle(fontSize: 10, color: changeColor),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildReferralItem(String platform, String amount, String subtitle, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(platform, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("WELCOME BACK", style: TextStyle(fontSize: 10)),
                      Text("Jack Doeson", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/img/user.jpg'),
                    radius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Filter
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Last 7 Days", style: TextStyle(color: Colors.grey)),
                    Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Metrics Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMetricCard(
                    title: "Followers",
                    value: "2.531",
                    changeText: "↑ 2.5% vs last 7 days",
                    icon: Icons.people,
                    iconColor: Colors.green,
                    changeColor: Colors.green,
                  ),
                  _buildMetricCard(
                    title: "Reactions",
                    value: "25.351",
                    changeText: "↓ 8.5% vs last 7 days",
                    icon: Icons.favorite,
                    iconColor: Colors.redAccent,
                    changeColor: Colors.red,
                  ),
                  _buildMetricCard(
                    title: "Reach",
                    value: "351.12k",
                    changeText: "↑ 24.5% vs last 7 days",
                    icon: Icons.mail,
                    iconColor: Colors.amber,
                    changeColor: Colors.green,
                  ),
                  _buildMetricCard(
                    title: "Comments",
                    value: "1.351",
                    changeText: "↔︎ vs last 7 days",
                    icon: Icons.comment,
                    iconColor: Colors.blue,
                    changeColor: Colors.blue,
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Text("ACQUISITION", style: TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 4),
              const Text("Referrals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // Referrals List
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: Column(
                  children: [
                    _buildReferralItem(
                      "Facebook",
                      "\$53.15",
                      "Organic Users",
                      Colors.blue,
                      Icons.facebook,
                    ),
                    _buildReferralItem(
                      "Google",
                      "25.30%",
                      "Sponsored Ads",
                      Colors.redAccent,
                      Icons.g_mobiledata,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

