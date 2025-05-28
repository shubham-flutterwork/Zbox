import 'package:flutter/material.dart';
import '../constants/color.dart';  // Your shared colors

class VendorManagementScreen extends StatefulWidget {
  const VendorManagementScreen({super.key});

  @override
  State<VendorManagementScreen> createState() => _VendorManagementScreenState();
}

class _VendorManagementScreenState extends State<VendorManagementScreen> {
  final List<Map<String, dynamic>> vendors = [
    {
      "name": "FurnitureWorld",
      "category": "Furniture",
      "contact": "+91 9876543210",
      "email": "support@furnitureworld.com",
      "status": "Active",
    },
    {
      "name": "TechGuru",
      "category": "Electronics",
      "contact": "+91 9123456780",
      "email": "hello@techguru.in",
      "status": "Inactive",
    },
    {
      "name": "StarkMotors",
      "category": "Vehicles",
      "contact": "+91 9988776655",
      "email": "sales@starkmotors.com",
      "status": "Active",
    },
  ];

  void _toggleStatus(int index) {
    setState(() {
      vendors[index]['status'] = vendors[index]['status'] == 'Active' ? 'Inactive' : 'Active';
    });
  }

  void _deleteVendor(int index) {
    setState(() {
      vendors.removeAt(index);
    });
  }

  void _addVendorDialog() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final contactController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Vendor", style: TextStyle(color: AppColors.red)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: AppColors.blue),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
                labelStyle: TextStyle(color: AppColors.blue),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            TextField(
              controller: contactController,
              decoration: const InputDecoration(
                labelText: "Contact",
                labelStyle: TextStyle(color: AppColors.blue),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: AppColors.blue),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                vendors.add({
                  "name": nameController.text,
                  "category": categoryController.text,
                  "contact": contactController.text,
                  "email": emailController.text,
                  "status": "Active",
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.white),
            child: const Text("Add Vendor",style: TextStyle(color:  AppColors.blue),),
          )
        ],
      ),
    );
  }

  Widget _buildVendorCard(Map<String, dynamic> vendor, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: ListTile(
        title: Text(
          vendor['name'],
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.red),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category: ${vendor['category']}", style: const TextStyle(color: Colors.black)),
            Text("Contact: ${vendor['contact']}", style: const TextStyle(color: Colors.black)),
            Text("Email: ${vendor['email']}", style: const TextStyle(color: Colors.black)),
            Text(
              "Status: ${vendor['status']}",
              style: TextStyle(
                color: vendor['status'] == 'Active' ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Toggle') {
              _toggleStatus(index);
            } else if (value == 'Delete') {
              _deleteVendor(index);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'Toggle', child: Text('Toggle Status', style: TextStyle(color: Colors.black))),
            const PopupMenuItem(value: 'Delete', child: Text('Delete', style: TextStyle(color: Colors.black))),
          ],
          icon: const Icon(Icons.more_vert, color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.blue,
        title: const Text(
          "Vendor Management",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: AppColors.white,
            onPressed: _addVendorDialog,
            tooltip: "Add Vendor",
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) => _buildVendorCard(vendors[index], index),
      ),
    );
  }
}
