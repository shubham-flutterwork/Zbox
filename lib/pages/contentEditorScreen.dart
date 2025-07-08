import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../widgets/editorScreen.dart';

class ContentManagementScreen extends StatelessWidget {
  final List<String> contentPages = [
    "Terms & Conditions",
    "Privacy Policy",
    "About Us"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.blue,
          title: const Text("Content Management")),
      body: ListView.builder(
        itemCount: contentPages.length,
        itemBuilder: (context, index) {
          final page = contentPages[index];
          return ListTile(
            title: Text(page),
            trailing: const Icon(Icons.edit),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditorScreen(pageTitle: page),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
