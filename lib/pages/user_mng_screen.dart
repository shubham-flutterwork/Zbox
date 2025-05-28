import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../constants/color.dart'; // import your AppColors

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  String selectedRole = 'All';
  String selectedStatus = 'All';

  final List<Map<String, dynamic>> users = [
    {'name': 'Alice', 'role': 'Admin', 'status': 'Active'},
    {'name': 'Bob', 'role': 'Vendor', 'status': 'Inactive'},
    {'name': 'Charlie', 'role': 'Customer', 'status': 'Active'},
  ];

  void _showUserForm({Map<String, dynamic>? existingUser}) {
    final isEdit = existingUser != null;
    final nameController = TextEditingController(text: existingUser?['name']);
    String role = existingUser?['role'] ?? 'Customer';
    String status = existingUser?['status'] ?? 'Active';

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
              children: [
                Text(
                  isEdit ? 'Edit User' : 'Add New User',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField2<String>(
                  value: role,
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: AppColors.whiteShade,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                    ),
                  ),
                  items: ['Admin', 'Vendor', 'Customer']
                      .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                      .toList(),
                  onChanged: (value) => setModalState(() => role = value!),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField2<String>(
                  value: status,
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: AppColors.whiteShade,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                    ),
                  ),
                  items: ['Active', 'Inactive']
                      .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (value) => setModalState(() => status = value!),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    minimumSize: const Size.fromHeight(45),
                  ),
                  onPressed: () {
                    final newUser = {
                      'name': nameController.text,
                      'role': role,
                      'status': status,
                    };

                    setState(() {
                      if (isEdit) {
                        final index = users.indexOf(existingUser);
                        users[index] = newUser;
                      } else {
                        users.add(newUser);
                      }
                    });

                    Navigator.pop(context);
                  },
                  child: Text(
                    isEdit ? 'Update User' : 'Add User',
                    style: const TextStyle(color: AppColors.white),
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
    final filteredUsers = users.where((user) {
      final matchesRole = selectedRole == 'All' || user['role'] == selectedRole;
      final matchesStatus = selectedStatus == 'All' || user['status'] == selectedStatus;
      return matchesRole && matchesStatus;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const Text(
          'User Management',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _showUserForm(),
            tooltip: 'Add New User',
            color: AppColors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField2<String>(
                    value: selectedRole,
                    decoration: InputDecoration(
                      labelText: 'Role',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: AppColors.whiteShade,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                      ),
                    ),
                    items: ['All', 'Admin', 'Vendor', 'Customer']
                        .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedRole = value!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField2<String>(
                    value: selectedStatus,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: AppColors.whiteShade,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                      ),
                    ),
                    items: ['All', 'Active', 'Inactive']
                        .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedStatus = value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // User List
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  final isInactive = user['status'] == 'Inactive';
                  return Card(
                    color: isInactive ? AppColors.redLight : AppColors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.blue,
                        foregroundColor: AppColors.white,
                        child: Text(user['name'][0]),
                      ),
                      title: Text(user['name']),
                      subtitle: Text('${user['role']} • ${user['status']}',
                          style: TextStyle(
                            color: isInactive ? AppColors.red : AppColors.blue,
                            fontWeight: FontWeight.w600,
                          )),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showUserForm(existingUser: user);
                          } else if (value == 'reset') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Password reset for ${user['name']}')),
                            );
                          } else if (value == 'block') {
                            setState(() {
                              user['status'] = 'Inactive';
                            });
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'edit', child: Text('Edit')),
                          const PopupMenuItem(value: 'reset', child: Text('Reset Password')),
                          const PopupMenuItem(value: 'block', child: Text('Block / Deactivate')),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
