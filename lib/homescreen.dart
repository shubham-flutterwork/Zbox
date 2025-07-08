import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zbox_admin/pages/contentEditorScreen.dart';
import 'package:zbox_admin/pages/notification_mng_screen.dart';
import 'constants/color.dart';
import 'package:zbox_admin/pages/order_mng_screen.dart';
import 'package:zbox_admin/pages/product_mng_screen.dart';
import 'package:zbox_admin/pages/reports&logs_screen.dart';
import 'package:zbox_admin/pages/role_mng_screen.dart';
import 'package:zbox_admin/pages/user_mng_screen.dart';
import 'package:zbox_admin/pages/vendor_mng_screen.dart';

class AdminHomePage extends StatefulWidget {
  final bool showBarLineChart;
  final bool showPieChart;
  final bool showRingChart;
  final bool showHeatmap;
  final bool showQuickAccess;

  const AdminHomePage({
    super.key,
    this.showBarLineChart = true,
    this.showPieChart = true,
    this.showRingChart = true,
    this.showHeatmap = true,
    this.showQuickAccess = true,
  });

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.showBarLineChart) ...[
          Text('Dashboard Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.red)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatBox("Users", "1,200", Icons.person, Colors.blue),
              _buildStatBox("Orders", "980", Icons.shopping_cart, Colors.green),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatBox("Revenue", "₹2.5L", Icons.attach_money, Colors.purple),
              _buildStatBox("Low Stock", "12", Icons.warning, Colors.orange),
            ],
          ),
          const SizedBox(height: 16),
          _buildChartContainer(height: 300, child: _buildBarAndLineChart()),
          const SizedBox(height: 24),
        ],
        if (widget.showPieChart) ...[
          _buildChartContainer(height: 220, child: _buildPieChart()),
          const SizedBox(height: 24),
        ],
        if (widget.showRingChart) ...[
          _buildChartContainer(height: 264, child: _buildMultiRingChartSection()),
          const SizedBox(height: 32),
        ],
        if (widget.showHeatmap) ...[
          Text('Activity Calendar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.red)),
          const SizedBox(height: 16),
          _buildChartContainer(height: 400, child: const CalendarHeatmap()),
          const SizedBox(height: 32),
        ],
        if (widget.showQuickAccess) ...[
          Text('Quick Access',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.red)),
          const SizedBox(height: 16),
          _buildQuickAccessGrid(context),
        ]
      ]),
    );
  }

  Widget _buildChartContainer({required double height, required Widget child}) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkCard : AppColors .whiteShade,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.transparent : Colors.grey.withOpacity(0.3),
            blurRadius: 8,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildBarAndLineChart() {
    return Stack(children: [
      BarChart(
        BarChartData(
          maxY: 100,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) =>
                    Text('${value.toInt()}', style: TextStyle(color: AppColors.blue)),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  return Text(labels[value.toInt()], style: TextStyle(color: AppColors.blue));
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            7,
                (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: [40, 50, 70, 60, 80, 45, 90][i].toDouble(),
                  color: AppColors.blue.withOpacity(0.3),
                  width: 16,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            ),
          ),
        ),
      ),
      LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: AppColors.red,
              barWidth: 3,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: true),
              spots: const [
                FlSpot(0, 40),
                FlSpot(1, 50),
                FlSpot(2, 70),
                FlSpot(3, 60),
                FlSpot(4, 80),
                FlSpot(5, 45),
                FlSpot(6, 90),
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 40,
        sectionsSpace: 6,
        sections: [
          PieChartSectionData(
            value: 20,
            title: 'Admins',
            color: AppColors.blue,
            radius: 60,
            titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white),
            badgeWidget: Icon(Icons.admin_panel_settings, color: AppColors.white, size: 24),
            badgePositionPercentageOffset: .98,
          ),
          PieChartSectionData(
            value: 30,
            title: 'Vendors',
            color: AppColors.red,
            radius: 60,
            titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white),
            badgeWidget: Icon(Icons.store, color: AppColors.white, size: 24),
            badgePositionPercentageOffset: .98,
          ),
          PieChartSectionData(
            value: 50,
            title: 'Customers',
            color: isDarkMode ? AppColors.darkGrey : AppColors.white,
            radius: 60,
            titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,  color: isDarkMode ? AppColors.white :AppColors.blue,),
            badgeWidget: Icon(Icons.people, color: isDarkMode ? AppColors.white :AppColors.blue, size: 24),
            badgePositionPercentageOffset: .98,
          ),
        ],
      ),
    );
  }

  Widget _buildMultiRingChartSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const MultiRingProgressChart(),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _Legend(label: 'Order Created', color: AppColors.blue),
            SizedBox(height: 12),
            _Legend(label: 'Shipment', color: AppColors.red),
            SizedBox(height: 12),
            _Legend(label: 'Shipment Delivered', color: AppColors.blue),
            SizedBox(height: 12),
            _Legend(label: 'Status', color: AppColors.red),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _AdminCard(title: 'User Management', icon: Icons.manage_accounts, color: AppColors.blue,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserManagementScreen()))),
        _AdminCard(title: 'Role Management', icon: Icons.security, color: AppColors.red,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoleManagementScreen()))),
        _AdminCard(title: 'Product Management', icon: Icons.inventory, color: AppColors.red,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductManagementScreen()))),
        _AdminCard(title: 'Order Management', icon: Icons.receipt_long, color: AppColors.blue,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderManagementScreen()))),
        _AdminCard(title: 'Vendor Management', icon: Icons.store, color: AppColors.blue,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VendorManagementScreen()))),
        _AdminCard(title: 'Reports & Logs', icon: Icons.bar_chart, color: AppColors.red,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminReportsLogsScreen()))),
        _AdminCard(title: 'Content & Policy Management', icon: Icons.privacy_tip_outlined, color: AppColors.red,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContentManagementScreen()))),
        _AdminCard(title: 'Notification Management', icon: Icons.notification_add_outlined, color: AppColors.blue,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationManagementScreen()))),
      ],
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon, Color iconColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ]),
      ),
    );
  }
}

class CalendarHeatmap extends StatefulWidget {
  const CalendarHeatmap({super.key});

  @override
  State<CalendarHeatmap> createState() => _CalendarHeatmapState();
}

class _CalendarHeatmapState extends State<CalendarHeatmap> {
  final Map<DateTime, int> _activityData = {};

  @override
  void initState() {
    super.initState();
    _generateActivityData();
  }

  void _generateActivityData() {
    DateTime startDate = DateTime(2025, 4, 1);
    DateTime endDate = DateTime(2025, 6, 11);
    while (!startDate.isAfter(endDate)) {
      _activityData[DateTime.utc(startDate.year, startDate.month, startDate.day)] = 2 + Random().nextInt(7);
      startDate = startDate.add(const Duration(days: 1));
    }
  }

  Color getColorForValue(int value) {
    if (value >= 6) return AppColors.red;
    if (value >= 4) return AppColors.blue;
    if (value >= 2) return AppColors.blue.withOpacity(0.3);
    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TableCalendar(
      firstDay: DateTime.utc(2025, 4, 1),
      lastDay: DateTime.utc(2025, 6, 30),
      focusedDay: DateTime.utc(2025, 6, 11),
      headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, _) {
          final key = DateTime.utc(date.year, date.month, date.day);
          final value = _activityData[key];
          final bool isFutureDate = date.isAfter(DateTime.now());

          final bgColor = value != null
              ? getColorForValue(value)
              : isDarkMode
              ? Colors.grey[800]   // Use dark grey for empty dates in dark mode
              : Colors.grey[200];  // Use light grey in light mode

          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isFutureDate ? (isDarkMode ? Colors.grey[850] : Colors.grey[300]) : bgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isFutureDate
                        ? (isDarkMode ? Colors.white60 : Colors.black38)
                        : (isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
                if (value != null)
                  Text(
                    '$value visits',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MultiRingProgressChart extends StatelessWidget {
  const MultiRingProgressChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(180, 180),
      painter: RingProgressPainter(
        progresses: [0.78, 0.65, 0.90, 0.50],
        colors: [AppColors.blue, AppColors.red, AppColors.blue, AppColors.red],
        strokeWidths: [12, 12, 12, 12], // reduced stroke width as per your request
      ),
    );
  }
}

class RingProgressPainter extends CustomPainter {
  final List<double> progresses;
  final List<Color> colors;
  final List<double> strokeWidths;

  RingProgressPainter({required this.progresses, required this.colors, required this.strokeWidths});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    double currentRadius = radius;
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < progresses.length; i++) {
      final bgPaint = Paint()
        ..color = colors[i].withOpacity(0.2)
        ..strokeWidth = strokeWidths[i]
        ..style = PaintingStyle.stroke;

      final fgPaint = Paint()
        ..color = colors[i]
        ..strokeWidth = strokeWidths[i]
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawCircle(center, currentRadius - strokeWidths[i] / 2, bgPaint);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: currentRadius - strokeWidths[i] / 2),
        -pi / 2,
        2 * pi * progresses[i],
        false,
        fgPaint,
      );

      currentRadius -= strokeWidths[i] + 8;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _Legend extends StatelessWidget {
  final String label;
  final Color color;

  const _Legend({required this.label, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 14, color: isDarkMode ? AppColors.white : AppColors.darkBlue,)),
      ],
    );
  }
}

class _AdminCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AdminCard({required this.title, required this.icon, required this.color, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
