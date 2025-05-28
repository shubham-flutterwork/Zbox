import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/color.dart';

class AdminReportsLogsScreen extends StatefulWidget {
  const AdminReportsLogsScreen({super.key});

  @override
  State<AdminReportsLogsScreen> createState() => _AdminReportsLogsScreenState();
}

class _AdminReportsLogsScreenState extends State<AdminReportsLogsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedReport = 'Sales';
  String selectedDateRange = 'Last 7 Days';

  final List<String> reportTypes = ['Sales', 'Inventory', 'Users'];
  final List<String> dateRanges = ['Today', 'Last 7 Days', 'Last 30 Days', 'Custom'];

  DateTime? customStartDate;
  DateTime? customEndDate;

  final logs = [
    {"time": "2025-05-12 10:00", "type": "Login", "action": "Admin logged in"},
    {"time": "2025-05-12 10:05", "type": "Update", "action": "Product 'Chair' updated"},
    {"time": "2025-05-12 10:15", "type": "Signup", "action": "New user registered"},
    {"time": "2025-05-12 10:30", "type": "System", "action": "Inventory sync completed"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _selectCustomDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        customStartDate = picked.start;
        customEndDate = picked.end;
        selectedDateRange = 'Custom';
      });
    }
  }

  Widget _buildReportSummary(String reportType) {
    TextStyle headingStyle = const TextStyle(fontSize: 18, color: AppColors.red);
    TextStyle infoStyle = const TextStyle(fontSize: 18, color: AppColors.blue);

    switch (reportType) {
      case 'Sales':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Sales:", style: headingStyle),
            Text("₹120,000", style: infoStyle),
            Text("Orders: 230", style: infoStyle),
            Text("Top Product: Laptop", style: infoStyle),
          ],
        );
      case 'Inventory':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Products:", style: headingStyle),
            Text("150", style: infoStyle),
            Text("Low Stock Items: 12", style: infoStyle),
            Text("Restock Alerts: 5", style: infoStyle),
          ],
        );
      case 'Users':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Active Users:", style: headingStyle),
            Text("180", style: infoStyle),
            Text("New Signups: 25", style: infoStyle),
            Text("Banned Accounts: 3", style: infoStyle),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildLineChart(List<FlSpot> dataPoints, Color color) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
        titlesData: FlTitlesData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints,
            isCurved: true,
            color: color,
            barWidth: 3,
            belowBarData: BarAreaData(show: true, color: color.withOpacity(0.2)),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateDataPoints(String reportType) {
    switch (reportType) {
      case 'Sales':
        return [FlSpot(1, 10000), FlSpot(2, 15000), FlSpot(3, 12000), FlSpot(4, 17000), FlSpot(5, 14000), FlSpot(6, 20000), FlSpot(7, 18000)];
      case 'Inventory':
        return [FlSpot(1, 80), FlSpot(2, 85), FlSpot(3, 82), FlSpot(4, 90), FlSpot(5, 88), FlSpot(6, 92), FlSpot(7, 89)];
      case 'Users':
        return [FlSpot(1, 5), FlSpot(2, 7), FlSpot(3, 6), FlSpot(4, 10), FlSpot(5, 9), FlSpot(6, 11), FlSpot(7, 8)];
      default:
        return [];
    }
  }

  Widget _buildChart(String reportType) {
    final data = _generateDataPoints(reportType);
    final color = reportType == 'Sales'
        ? AppColors.red
        : reportType == 'Inventory'
        ? AppColors.blue
        : AppColors.blue;

    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: _buildLineChart(data, color),
    );
  }

  Widget _buildReportTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedReport,
            decoration: const InputDecoration(
              labelText: "Select Report Type",
              labelStyle: TextStyle(color: AppColors.red),
              border: OutlineInputBorder(),
            ),
            items: reportTypes.map((type) {
              return DropdownMenuItem(value: type, child: Text(type));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => selectedReport = value);
              }
            },
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedDateRange,
            decoration: const InputDecoration(
              labelText: "Select Date Range",
              labelStyle: TextStyle(color: AppColors.red),
              border: OutlineInputBorder(),
            ),
            items: dateRanges.map((range) {
              return DropdownMenuItem(value: range, child: Text(range));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                if (value == 'Custom') {
                  _selectCustomDateRange();
                } else {
                  setState(() => selectedDateRange = value);
                }
              }
            },
          ),
          if (selectedDateRange == 'Custom' && customStartDate != null && customEndDate != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'From: ${DateFormat('yyyy-MM-dd').format(customStartDate!)} to ${DateFormat('yyyy-MM-dd').format(customEndDate!)}',
                style: const TextStyle(fontSize: 16, color: AppColors.blue),
              ),
            ),
          const SizedBox(height: 20),
          _buildReportSummary(selectedReport),
          const SizedBox(height: 16),
          _buildChart(selectedReport),
        ],
      ),
    );
  }

  Widget _buildLogsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        Color iconColor;
        switch (log['type']) {
          case 'Login':
            iconColor = AppColors.blue;
            break;
          case 'Error':
            iconColor = AppColors.red;
            break;
          default:
            iconColor = AppColors.blue;
        }

        return Card(
          color: AppColors.whiteShade,
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 2,
          child: ListTile(
            leading: Icon(Icons.bubble_chart, color: iconColor),
            title: Text(log['action']!, style: const TextStyle(color: AppColors.blue)),
            subtitle: Text("Time: ${log['time']} | Type: ${log['type']}", style: const TextStyle(color: AppColors.red)),
            trailing: const Icon(Icons.chevron_right, color: AppColors.blue),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: const Text("Reports & Logs", style: TextStyle(color: AppColors.white)),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
       body: Column(
    children: [
    Container(
    color: AppColors.white, // Red background for TabBar
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.red,
        unselectedLabelColor: AppColors.blue.withOpacity(0.7),
        indicatorColor: AppColors.red,
        tabs: const [
          Tab(icon: Icon(Icons.bar_chart), text: 'Reports'),
          Tab(icon: Icon(Icons.history), text: 'Logs'),
        ],
      ),
    ),
    Expanded(
    child: TabBarView(
    controller: _tabController,
    children: [
    _buildReportTab(),
    _buildLogsTab(),
    ],
    ),
    ),
    ],
    ),
    );
  }
}
