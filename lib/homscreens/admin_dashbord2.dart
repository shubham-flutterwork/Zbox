import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminDashboard2 extends StatelessWidget {
  const AdminDashboard2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F8FB),
        fontFamily: 'Arial',
      ),
      home: const DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  Widget _buildMarketingCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Marketeking',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 187,
            width: 125,
            child: CustomPaint(
              painter: _MultiRingPainter(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildVisitorCard() {
    return Column(
      children: [
        _infoCard('20k', 'visitors today', Colors.white, null, addIcon: true),
        const SizedBox(height: 10),
        _infoCard('21k', 'Fixed visitor', const Color(0xFFf76c6c), Colors.white,
            smallGraph: true),
        const SizedBox(height: 10),
        _infoCard('205k', 'Today income', Colors.white, null, addIcon: true),
      ],
    );
  }

  Widget _infoCard(String value, String label, Color bgColor, Color? textColor,
      {bool addIcon = false, bool smallGraph = false}) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: bgColor == Colors.white
            ? const [BoxShadow(color: Colors.black12, blurRadius: 8)]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: textColor != null
                      ? textColor.withOpacity(0.8)
                      : Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 12
                ),
              ),
              if (addIcon)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.show_chart_rounded,
                    size: 14,
                    color: Colors.blue.shade400,
                  ),
                ),
              if (smallGraph) ...[
                const Spacer(),
                Container(
                  width: 30,
                  height: 12,
                  decoration: BoxDecoration(
                    color: textColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  // placeholder small wave
                  child: CustomPaint(painter: _SmallWavePainter()),
                )
              ]
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Revenue',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _choiceChip('Analolde', true),
              const SizedBox(width: 8),
              _choiceChip('Dairy', false),
              const SizedBox(width: 8),
              _choiceChip('M', false),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 20,
                  verticalInterval: 4,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, interval: 20),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 4,
                      getTitlesWidget: (value, meta) {
                        final labels = ['0', '4', '9', '10', '12'];
                        if (value.toInt() < labels.length) {
                          return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(labels[value.toInt()]));
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(13, (i) {
                      double y = 60 - (20 * (i % 6));
                      return FlSpot(i.toDouble(), y.toDouble());
                    }),
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 2,
                    dotData: FlDotData(show: true),
                  ),
                  LineChartBarData(
                    spots: List.generate(13, (i) {
                      double y = 40 + (20 * (i % 6));
                      return FlSpot(i.toDouble(), y.toDouble());
                    }),
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 2,
                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _choiceChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildCompanyRevenue() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 220),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Company Revenue',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Icon(Icons.info_outline, size: 16, color: Colors.black54),
              SizedBox(width: 12),
              Icon(Icons.query_stats, size: 18, color: Colors.black54),
              SizedBox(width: 12),
              Icon(Icons.search, size: 18, color: Colors.black54),
              SizedBox(width: 12),
              Icon(Icons.home, size: 18, color: Colors.black54),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 10,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: Colors.grey.shade200)),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        interval: 2,
                        getTitlesWidget: (value, meta) {
                          final months = [
                            'Apr',
                            'May',
                            'Jun',
                            'Jul',
                            'Aug',
                            'Sept',
                            'Sept 1'
                          ];
                          int index = value.toInt() ~/ 2;
                          if (index >= 0 && index < months.length) {
                            return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(months[index]));
                          }
                          return const SizedBox.shrink();
                        }),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, interval: 10),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 20),
                      FlSpot(1, 30),
                      FlSpot(2, 45),
                      FlSpot(3, 50),
                      FlSpot(4, 40),
                      FlSpot(5, 30),
                      FlSpot(6, 35),
                      FlSpot(7, 25),
                      FlSpot(8, 10),
                      FlSpot(9, 15),
                      FlSpot(10, 18),
                      FlSpot(11, 12),
                      FlSpot(12, 20),
                    ],
                    isCurved: true,
                    barWidth: 4,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent.withOpacity(0.8),
                          Colors.blueAccent.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    color: Colors.blue,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    final blueBar = Colors.blue.shade800;
    final lightBlueBar = Colors.blue.shade200;
    final months = [
      'ann',
      'Feb',
      'Pat',
      'Apr',
      'May',
      'Jan',
      'Jun',
      'Aug',
      'Sop',
      'Oct'
    ];
    final blueValues = [8, 10, 11, 12, 13, 15, 17, 18, 16, 20];
    final lightBlueValues = [12, 14, 15, 18, 19, 20, 22, 24, 23, 25];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('Blue Valley',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600)),
              SizedBox(width: 12),
              Text('League Valley',
                  style: TextStyle(
                      color: Colors.blueAccent, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 5,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.shade200,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      reservedSize: 28,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int idx = value.toInt();
                        if (idx >= 0 && idx < months.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(months[idx]),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      interval: 1,
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(
                  months.length,
                  (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: blueValues[index].toDouble(),
                        color: blueBar,
                        width: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      BarChartRodData(
                        toY: lightBlueValues[index].toDouble(),
                        color: lightBlueBar,
                        width: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                    barsSpace: 6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesOverview() {
    const white = Colors.white;
    final blue = Colors.blue.shade600;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _salesColumn('404', '\$0,340', '+15%'),
          _miniGraphWidget(),
          _salesColumn('\$937k', '-2,605', '15%'),
          _miniGraphWidget(),
        ],
      ),
    );
  }

  Widget _salesColumn(String mainValue, String subValue, String percent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainValue,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        Text(
          subValue,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        Text(
          percent,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _miniGraphWidget() {
    return SizedBox(
      width: 100,
      height: 50,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          barGroups: List.generate(
              20,
              (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: (index % 6 + 1) * 4,
                        color: Colors.white,
                        width: 3,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ],
                  )),
        ),
      ),
    );
  }

  Widget _buildRooms() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search....',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Executive Suite 455',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.70,
              minHeight: 16,
              backgroundColor: Colors.blue.shade100,
              color: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          width: double.infinity,
          'https://storage.googleapis.com/workspace-0f70711f-8b4e-4d94-86f1-2a93ccde5887/image/60f82dde-62ce-4ffc-b669-7de0d29729f7.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
                child: Text('Map loading failed',
                    style: TextStyle(color: Colors.grey.shade400)));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Responsive grid-like layout
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.dashboard_rounded,color: Colors.white,),
        title:Column(
        children: [
          Text('Welcome',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,color: Colors.white),),
          Text('Admin',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.white),),
        ],
      ),backgroundColor: Color(0xFFf76c6c)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(builder: (context, constraints) {
          double width = constraints.maxWidth;
          bool isWide = width > 900;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.remove_red_eye_outlined,
                      iconColor: Colors.green,
                      value: "27.4k",
                      label: "Visitors Today",
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.attach_money_outlined,
                      iconColor: Colors.orange,
                      value: "\$29.2k",
                      label: "Total Earnings",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: const [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.red,
                      value: "45",
                      label: "Pending Orders",
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.notifications_active_outlined,
                      iconColor: Colors.teal,
                      value: "14",
                      label: "Notifications",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _buildMarketingCard()),
                        const SizedBox(width: 16),
                        Expanded(flex: 1, child: _buildVisitorCard()),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMarketingCard(),
                        const SizedBox(width: 10),
                        _buildVisitorCard(),
                      ],
                    ),
              const SizedBox(height: 20),
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildBarChart()),
                        const SizedBox(width: 16),
                        Expanded(flex: 2, child: _buildRevenueChart()),
                      ],
                    )
                  : Column(
                      children: [
                        _buildBarChart(),
                        const SizedBox(height: 16),
                        _buildRevenueChart(),
                      ],
                    ),
              const SizedBox(height: 20),
              _buildCompanyRevenue(),
              _buildSalesOverview(),
              isWide
                  ? Row(
                      children: [
                        Expanded(child: _buildRooms()),
                        const SizedBox(width: 16),
                        Expanded(child: _buildMap()),
                      ],
                    )
                  : Column(
                      children: [
                        _buildRooms(),
                        const SizedBox(height: 16),
                        _buildMap()
                      ],
                    ),
            ],
          );
        }),
      ),
    );
  }
}

// CustomPainter to draw the multiple rings with colors like in the circle
class _MultiRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    void drawRing(double radius, Color color, double startAngle,
        double sweepAngle, double strokeWidth) {
      final paint = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startAngle, sweepAngle, false, paint);
    }

    const fullSweep = 2 * 3.1415926535;

    drawRing(size.width * 0.55, Colors.blue, -1.5, fullSweep * 0.7, 8);
    drawRing(size.width * 0.45, Colors.red.shade400, -1.0, fullSweep * 0.8, 8);
    drawRing(size.width * 0.35, Colors.teal, -5.0, fullSweep * 0.8, 8);
    drawRing(size.width * 0.25, Colors.purple, -2.2, fullSweep * 0.75, 8);
    drawRing(size.width * 0.15, Colors.yellow, -1.2, fullSweep * 0.75, 8);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// CustomPainter for the small wave inside the red visitor box
class _SmallWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final waveHeight = size.height / 2;
    final waveLength = size.width / 4;

    path.moveTo(0, waveHeight);

    for (int i = 0; i < 5; i++) {
      path.relativeQuadraticBezierTo(
          waveLength / 2, -waveHeight, waveLength, 0);
      path.relativeQuadraticBezierTo(waveLength / 2, waveHeight, waveLength, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 69,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          CircleAvatar(
            radius: 22,
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(icon, color: iconColor, size: 24),
          ),
        ],
      ),
    );
  }
}
