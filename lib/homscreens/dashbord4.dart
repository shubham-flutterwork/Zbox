import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Dashboard4 extends StatelessWidget {
  const Dashboard4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // AppBar section
              Container(
                height: 140,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("ACCOUNT", style: TextStyle(fontSize: 12, color: Colors.white70)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          "Lock & Keye",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const Spacer(),
                        const Icon(Icons.refresh_outlined, color: Colors.white, size: 30),
                      ],
                    ),
                  ],
                ),
              ),

              // Overlapping "THIS MONTH" card
              Transform.translate(
                offset: const Offset(0, -50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("THIS MONTH, ",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.blue)),

                            const Text("\$6,750",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: 170,
                                child: PieChart(
                                  PieChartData(
                                    sectionsSpace: 1,
                                    centerSpaceRadius: 50,
                                    sections: [
                                      PieChartSectionData(value: 40, color: Colors.pink[300], radius: 25),
                                      PieChartSectionData(value: 20, color: Colors.purple[400], radius: 25),
                                      PieChartSectionData(value: 8, color: Colors.green[400], radius: 25),
                                      PieChartSectionData(value: 22, color: Colors.blue[400], radius: 25),
                                      PieChartSectionData(value: 7, color: Colors.teal[200], radius: 25),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Types of Expenses",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.blue),
                                  ),
                                  const SizedBox(height: 10),
                                  _LegendItem(icon: Icons.home, label: "Rental", color: Colors.pink),
                                  _LegendItem(icon: Icons.shopping_bag, label: "Shopping", color: Colors.purple),
                                  _LegendItem(icon: Icons.local_grocery_store, label: "Grocery", color: Colors.green),
                                  _LegendItem(icon: Icons.medical_services, label: "Medicine", color: Colors.blue),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 100,
                          child: LineChart(
                            LineChartData(
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) => Text(
                                      ["JUL", "AUG", "SEP", "OCT", "NOV", "DEC", "JAN"]
                                          .elementAt(value.toInt() % 7),
                                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                                    ),
                                    reservedSize: 28,
                                  ),
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  isCurved: true,
                                  color: Colors.lightBlue,
                                  dotData: FlDotData(show: true),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.lightBlue.withOpacity(0.3),
                                        Colors.lightBlue.withOpacity(0.05),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  spots: const [
                                    FlSpot(0, 2),
                                    FlSpot(1, 3),
                                    FlSpot(2, 2.8),
                                    FlSpot(3, 2.3),
                                    FlSpot(4, 2.5),
                                    FlSpot(5, 2.2),
                                    FlSpot(6, 3.1),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // User List section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _UserTile(name: "Gary Singh", card: "0287", status: "included"),
                      Divider(),
                      _UserTile(name: "Ann Singh", card: "5864", status: "included"),
                      Divider(),
                      _UserTile(name: "Neena Singh", card: "7149", status: "add"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _LegendItem({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final String name;
  final String card;
  final String status;

  const _UserTile({required this.name, required this.card, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(backgroundImage: AssetImage('assets/img/user.jpg')),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("Debit Card ending in $card"),
      trailing: Icon(
        status == "included" ? Icons.check_circle : Icons.add_circle_outline,
        color: status == "included" ? Colors.green : Colors.grey,
      ),
    );
  }
}
