import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'widgets/drawer.dart';
import 'constants/color.dart';

class MyMenuPage extends StatefulWidget {
  const MyMenuPage({super.key, required this.title});
  final String title;

  @override
  State<MyMenuPage> createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: Text(widget.title,style: TextStyle(color: AppColors.white),),
      ),
      drawer: const AdminDrawer(),
      body: const AdminHomePage(),
    );
  }
}
