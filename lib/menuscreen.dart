import 'package:flutter/material.dart';
import 'package:zbox_admin/homscreens/admin_dashbord2.dart';
import 'package:zbox_admin/homscreens/dashbord1.dart';
import 'package:zbox_admin/homscreens/dashbord2.dart';
import 'package:zbox_admin/homscreens/dashbord3.dart';
import 'package:zbox_admin/homscreens/dashbord5.dart';
import 'homscreens/dashbord4.dart';
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
  final List<Widget> _pages = [
    AdminDashboard2(),
    HomePage1(),
    Dashboard2(),
    Dashboard3(),
    Dashboard4(),
    Dashboard5(),
  ];
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor:widget.themeNotifier.value == ThemeMode.dark  ? Colors.grey[900] : AppColors.blue,
      //   iconTheme: IconThemeData(
      //     color: widget.themeNotifier.value == ThemeMode.dark ? AppColors.red: Colors.white,
      //   ),
      //   titleSpacing: 0,
      //   title: Text(widget.title,
      //       style: TextStyle(
      //         color: widget.themeNotifier.value == ThemeMode.dark  ? AppColors.red: Colors.white,
      //         fontWeight: FontWeight.bold,
      //   )),
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         widget.themeNotifier.value == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
      //           color: widget.themeNotifier.value == ThemeMode.dark  ? AppColors.red: Colors.white,
      //       ),
      //       onPressed: () {
      //         widget.themeNotifier.value =
      //         widget.themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      //       },
      //     ),
      //     PopupMenuButton<String>(
      //       icon: Icon(Icons.tune,color: widget.themeNotifier.value == ThemeMode.dark  ? AppColors.red: Colors.white,
      //       ),
      //       onSelected: (value) {
      //         setState(() {
      //           switch (value) {
      //             case 'Bar+Line':
      //               showBarLineChart = !showBarLineChart;
      //               break;
      //             case 'Pie':
      //               showPieChart = !showPieChart;
      //               break;
      //             case 'Ring':
      //               showRingChart = !showRingChart;
      //               break;
      //             case 'Heatmap':
      //               showHeatmap = !showHeatmap;
      //               break;
      //             case 'Quick':
      //               showQuickAccess = !showQuickAccess;
      //               break;
      //           }
      //         });
      //       },
      //       itemBuilder: (_) => [
      //         CheckedPopupMenuItem(
      //             value: 'Bar+Line', checked: showBarLineChart, child: const Text('Bar + Line Chart')),
      //         CheckedPopupMenuItem(value: 'Pie', checked: showPieChart, child: const Text('Pie Chart')),
      //         CheckedPopupMenuItem(value: 'Ring', checked: showRingChart, child: const Text('Ring Chart')),
      //         CheckedPopupMenuItem(value: 'Heatmap', checked: showHeatmap, child: const Text('Heatmap')),
      //         CheckedPopupMenuItem(value: 'Quick', checked: showQuickAccess, child: const Text('Quick Access')),
      //       ],
      //     ),
      //     IconButton(onPressed: (){}, icon: Icon(Icons.logout_rounded,color: widget.themeNotifier.value == ThemeMode.dark  ? AppColors.red:Colors.white,
      //     ))
      //   ],
      // ),
      drawer: const AdminDrawer(),
      body: AdminDashboard2(),
      // body: AdminHomePage(
      //   // showBarLineChart: showBarLineChart,
      //   // showPieChart: showPieChart,
      //   // showRingChart: showRingChart,
      //   // showHeatmap: showHeatmap,
      //   // showQuickAccess: showQuickAccess,
      // ),



      // body: SafeArea(
      //   child: IndexedStack(
      //     index: _selectedIndex,
      //     children: _pages,
      //   ),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.red,
      //   unselectedItemColor: Colors.black54,
      //   currentIndex: _selectedIndex,
      //   onTap: _onTabTapped,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.star), label: "Features"),
      //     BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Pages"),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
      //     BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: "Profile"),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      //   ],
      // ),

    );
  }
}
