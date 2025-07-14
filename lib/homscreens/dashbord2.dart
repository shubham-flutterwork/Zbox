import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Dashboard2 extends StatelessWidget {
  const Dashboard2({super.key});

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color lineColor,
    required Color bgColor,
    IconData? trendIcon,
    Color? trendColor,
    required List<FlSpot> spots,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(width: 6),
              if (trendIcon != null)
                Icon(trendIcon, size: 16, color: trendColor ?? Colors.grey),
            ],
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 35),
          SizedBox(
            height: 40,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minY: 0,
                maxY: 2,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    dotData: FlDotData(show: false),
                    color: lineColor,
                    barWidth: 2,
                    // belowBarData: BarAreaData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          lineColor.withOpacity(0.3),
                          lineColor.withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



  Widget _buildFollowerStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("INTERACTIONS", style: TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 4),
          const Text("Follower Stats", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) => Text(
                        value.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 10),
                      ),
                      reservedSize: 28,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minY: 1.1,
                maxY: 1.3,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 1.14),
                      FlSpot(1, 1.15),
                      FlSpot(2, 1.18),
                      FlSpot(3, 1.2),
                      FlSpot(4, 1.22),
                      FlSpot(5, 1.25),
                      FlSpot(6, 1.27),
                    ],
                    isCurved: true,
                    dotData: FlDotData(show: true),
                    color: Colors.blue,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.3),
                          Colors.blue.withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    barWidth: 2.5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
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
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Last 7 Days", style: TextStyle(color: Colors.black54)),
                    Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildStatCard(
                    title: "Weekly Income",
                    value: "\$1.150",
                    lineColor: Colors.green,
                    bgColor: Colors.green,
                    trendIcon: Icons.arrow_upward,
                    trendColor: Colors.green,
                      spots: const [
                        FlSpot(0, 0),
                        FlSpot(1, 2.6),
                        FlSpot(2, 3.3),
                        FlSpot(3, 4.5),
                      ]

                  ),
                  _buildStatCard(
                    title: "New Users",
                    value: "15.3k",
                    lineColor: Colors.blue,
                    bgColor: Colors.blue,
                    trendIcon: Icons.remove,
                    trendColor: Colors.blue,
                      spots: const [
                        FlSpot(0, 0),
                        FlSpot(1, 2.6),
                        FlSpot(2, 1.3),
                        FlSpot(3, 4.5),
                      ]
                  ),
                  _buildStatCard(
                    title: "New Users",
                    value: "35.1k",
                    lineColor: Colors.orange,
                    bgColor: Colors.orange,
                    trendIcon: Icons.arrow_downward,
                    trendColor: Colors.red,
                      spots: const [
                        FlSpot(0, 0),
                        FlSpot(1, 1.6),
                        FlSpot(2, 3.3),
                        FlSpot(3, 2.5),
                      ]                  ),
                  _buildStatCard(
                    title: "User Interactions",
                    value: "1.361",
                    lineColor: Colors.purple,
                    bgColor: Colors.purple,
                    trendIcon: Icons.arrow_upward,
                    trendColor: Colors.green,
                      spots: const [
                        FlSpot(0, 0),
                        FlSpot(1, 1.6),
                        FlSpot(2, 2.3),
                        FlSpot(3, 4.5),
                      ]                  ),
                ],
              ),
              _buildFollowerStats(),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy painter for line chart (replace with actual chart widget for real app)
class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.2, size.height * 0.6);
    path.lineTo(size.width * 0.4, size.height * 0.5);
    path.lineTo(size.width * 0.6, size.height * 0.4);
    path.lineTo(size.width * 0.8, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
