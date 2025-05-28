import 'package:flutter/material.dart';
import '../constants/color.dart'; // your shared colors

class RoleManagementScreen extends StatefulWidget {
  const RoleManagementScreen({super.key});

  @override
  State<RoleManagementScreen> createState() => _RoleManagementScreenState();
}

class _RoleManagementScreenState extends State<RoleManagementScreen> {
  final List<Map<String, dynamic>> roles = [
    {'role': 'Admin', 'description': 'Full access to system'},
    {'role': 'Vendor', 'description': 'Manages inventory and products'},
    {'role': 'Customer', 'description': 'End user with limited access'},
  ];

  void _showRoleForm({Map<String, dynamic>? existingRole}) {
    final isEdit = existingRole != null;
    final roleController = TextEditingController(text: existingRole?['role']);
    final descriptionController =
    TextEditingController(text: existingRole?['description']);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: StatefulBuilder(builder: (context, setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEdit ? 'Edit Role' : 'Add New Role',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.red,  // RED for headings
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: roleController,
                  decoration: InputDecoration(
                    labelText: 'Role Name',
                    labelStyle: TextStyle(color: AppColors.red), // RED label
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.blue), // BLUE border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.red), // RED focus
                    ),
                  ),
                  cursorColor: AppColors.red,
                  style: TextStyle(color: AppColors.blue), // BLUE text inside field
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: AppColors.red), // RED label
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.blue), // BLUE border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.red), // RED focus
                    ),
                  ),
                  cursorColor: AppColors.red,
                  style: TextStyle(color: AppColors.blue), // BLUE text
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    minimumSize: const Size.fromHeight(45),
                  ),
                  onPressed: () {
                    final newRole = {
                      'role': roleController.text,
                      'description': descriptionController.text,
                    };

                    setState(() {
                      if (isEdit) {
                        final index = roles.indexOf(existingRole);
                        roles[index] = newRole;
                      } else {
                        roles.add(newRole);
                      }
                    });

                    Navigator.pop(context);
                  },
                  child: Text(
                    isEdit ? 'Update Role' : 'Add Role',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Role Management',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add New Role',
            onPressed: () => _showRoleForm(),
            color: AppColors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: roles.length,
          itemBuilder: (context, index) {
            final role = roles[index];
            return Card(
              child: ListTile(
                leading: Icon(Icons.security, color: AppColors.blue), // BLUE icon
                title: Text(
                  role['role'],
                  style: TextStyle(color: AppColors.red), // RED title text
                ),
                subtitle: Text(
                  role['description'],
                  style: TextStyle(color: AppColors.blue), // BLUE subtitle
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showRoleForm(existingRole: role);
                    } else if (value == 'delete') {
                      setState(() {
                        roles.removeAt(index);
                      });
                    }
                  },
                  icon: Icon(Icons.more_vert, color: AppColors.blue), // BLUE menu icon
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'edit', child: Text('Edit')),
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
