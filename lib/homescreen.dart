import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zbox_admin/pages/order_mng_screen.dart';
import 'package:zbox_admin/pages/product_mng_screen.dart';
import 'package:zbox_admin/pages/reports&logs_screen.dart';
import 'package:zbox_admin/pages/role_mng_screen.dart';
import 'package:zbox_admin/pages/user_mng_screen.dart';
import 'package:zbox_admin/pages/vendor_mng_screen.dart';
import 'constants/color.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.red),
          ),
          const SizedBox(height: 16),
          _buildChartContainer(
            height: 300,
            child: Stack(
              children: [
                BarChart(
                  BarChartData(
                    maxY: 100,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) => Text('${value.toInt()}', style: TextStyle(color: AppColors.blue)),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
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
                    barGroups: [
                      for (int i = 0; i < 7; i++)
                        BarChartGroupData(
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
                    ],
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
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildChartContainer(
            height: 220,
            child: PieChart(
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
                    color: AppColors.white,
                    radius: 60,
                    titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.blue),
                    badgeWidget: Icon(Icons.people, color: AppColors.blue, size: 24),
                    badgePositionPercentageOffset: .98,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // _buildChartContainer(
          //   height: 312,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           _buildProgressRing('78%', AppColors.blue, AppColors.blueLight, 0.78),
          //           _buildProgressRing('65%', AppColors.red, AppColors.redLight, 0.65),
          //         ],
          //       ),
          //       const SizedBox(height: 8),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children:  [
          //           Container(
          //               width:125,alignment: Alignment.center,
          //               child: Text('Order Created', style: TextStyle(fontSize: 14, color: AppColors.blue))),
          //           Container(
          //               width:125,alignment: Alignment.center,
          //               child: Text('Shipment', style: TextStyle(fontSize: 14, color: AppColors.red))),
          //         ],
          //       ),
          //       const SizedBox(height: 24),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           _buildProgressRing('90%', AppColors.blue, AppColors.blueLight, 0.90),
          //           _buildProgressRing('50%', AppColors.red, AppColors.redLight, 0.50),
          //         ],
          //       ),
          //       const SizedBox(height: 8),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Container(
          //               width:125,alignment: Alignment.center,
          //               child: Text('Shipment Delivered', style: TextStyle(fontSize: 14, color: AppColors.blue))),
          //            Container(
          //                width:125,alignment: Alignment.center,
          //                child: Text('Status', style: TextStyle(fontSize: 14, color: AppColors.red))),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          _buildChartContainer(
            height: 264,
            child: Column(
              crossAxisAlignment: CrossAxisAlintialignment.start,
              children: [
                _buildLabeledProgressBar('Order Created', 0.78, AppColors.blue),
                const SizedBox(height: 16),
                _buildLabeledProgressBar('Shipment', 0.65, AppColors.red),
                const SizedBox(height: 16),
                _buildLabeledProgressBar('Shipment Delivered', 0.90, AppColors.blue),
                const SizedBox(height: 16),
                _buildLabeledProgressBar('Status', 0.50, AppColors.red),
              ],
            ),
          ),

          const SizedBox(height: 32),
          Text(
            'Quick Access',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.red),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _AdminCard(title: 'User Management', icon: Icons.manage_accounts, color: AppColors.blue, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserManagementScreen()));
              }),
              _AdminCard(title: 'Role Management', icon: Icons.security, color: AppColors.red, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleManagementScreen()));
              }),
              _AdminCard(title: 'Product Management', icon: Icons.inventory, color: AppColors.red, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductManagementScreen()));
              }),
              _AdminCard(title: 'Order Management', icon: Icons.receipt_long, color: AppColors.blue, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderManagementScreen()));
              }),
              _AdminCard(title: 'Vendor Management', icon: Icons.store, color: AppColors.blue, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const VendorManagementScreen()));
              }),
              _AdminCard(title: 'Reports & Logs', icon: Icons.bar_chart, color: AppColors.red, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminReportsLogsScreen()));
              }),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildChartContainer({required double height, required Widget child}) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: child,
    );
  }
  // Widget _buildProgressRing(String percent, Color color, Color bgColor, double value) {
  //   return Stack(
  //     alignment: Alignment.center,
  //     children: [
  //       SizedBox(
  //         height: 100,
  //         width: 100,
  //         child: CircularProgressIndicator(
  //           value: value,
  //           strokeWidth: 8,
  //           backgroundColor: bgColor,
  //           color: color,
  //         ),
  //       ),
  //       Text(percent, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
  //     ],
  //   );
  // }
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
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

Widget _buildLabeledProgressBar(String label, double value, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: value,
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text('${(value * 100).toInt()}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ],
    ),
  );
}
