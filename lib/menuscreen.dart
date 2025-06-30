import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'widgets/drawer.dart';
import 'constants/color.dart';

class MyMenuPage extends StatefulWidget {
  const MyMenuPage({
    super.key,
    required this.title,
    required this.themeNotifier,
  });

  final String title;
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<MyMenuPage> createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {
  bool showBarLineChart = true;
  bool showPieChart = true;
  bool showRingChart = true;
  bool showHeatmap = true;
  bool showQuickAccess = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: Text(widget.title, style: const TextStyle(color: AppColors.white)),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeNotifier.value == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () {
              widget.themeNotifier.value =
              widget.themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.tune, color: Colors.white),
            onSelected: (value) {
              setState(() {
                switch (value) {
                  case 'Bar+Line':
                    showBarLineChart = !showBarLineChart;
                    break;
                  case 'Pie':
                    showPieChart = !showPieChart;
                    break;
                  case 'Ring':
                    showRingChart = !showRingChart;
                    break;
                  case 'Heatmap':
                    showHeatmap = !showHeatmap;
                    break;
                  case 'Quick':
                    showQuickAccess = !showQuickAccess;
                    break;
                }
              });
            },
            itemBuilder: (_) => [
              CheckedPopupMenuItem(
                  value: 'Bar+Line', checked: showBarLineChart, child: const Text('Bar + Line Chart')),
              CheckedPopupMenuItem(value: 'Pie', checked: showPieChart, child: const Text('Pie Chart')),
              CheckedPopupMenuItem(value: 'Ring', checked: showRingChart, child: const Text('Ring Chart')),
              CheckedPopupMenuItem(value: 'Heatmap', checked: showHeatmap, child: const Text('Heatmap')),
              CheckedPopupMenuItem(value: 'Quick', checked: showQuickAccess, child: const Text('Quick Access')),
            ],
          ),
        ],
      ),
      drawer: const AdminDrawer(),
      body: AdminHomePage(
        showBarLineChart: showBarLineChart,
        showPieChart: showPieChart,
        showRingChart: showRingChart,
        showHeatmap: showHeatmap,
        showQuickAccess: showQuickAccess,
      ),
    );
  }
}
