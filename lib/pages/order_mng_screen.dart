import 'package:flutter/material.dart';
import '../constants/color.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  String selectedStatus = 'All';
  String selectedSort = 'Newest';
  String searchQuery = '';

  final List<Map<String, dynamic>> orders = [
    {'id': 'ORD001', 'user': 'Alice', 'status': 'Pending', 'date': DateTime(2024, 6, 1)},
    {'id': 'ORD002', 'user': 'Bob', 'status': 'Shipped', 'date': DateTime(2024, 5, 30)},
    {'id': 'ORD003', 'user': 'Charlie', 'status': 'Delivered', 'date': DateTime(2024, 5, 25)},
    {'id': 'ORD004', 'user': 'Diana', 'status': 'Pending', 'date': DateTime(2024, 6, 3)},
  ];

  void _showOrderForm({Map<String, dynamic>? existingOrder}) {
    final isEdit = existingOrder != null;
    final userController = TextEditingController(text: existingOrder?['user']);
    String selectedOrderStatus = existingOrder?['status'] ?? 'Pending';

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
                  isEdit ? 'Edit Order' : 'Add New Order',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: userController,
                  decoration: const InputDecoration(labelText: 'Customer Name'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedOrderStatus,
                  items: ['Pending', 'Shipped', 'Delivered']
                      .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ))
                      .toList(),
                  onChanged: (value) => setModalState(() => selectedOrderStatus = value!),
                  decoration: const InputDecoration(labelText: 'Order Status'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    minimumSize: const Size.fromHeight(45),
                  ),
                  onPressed: () {
                    final newOrder = {
                      'id': existingOrder?['id'] ?? 'ORD00${orders.length + 1}',
                      'user': userController.text,
                      'status': selectedOrderStatus,
                      'date': DateTime.now(),
                    };

                    setState(() {
                      if (isEdit) {
                        final index = orders.indexOf(existingOrder);
                        orders[index] = newOrder;
                      } else {
                        orders.add(newOrder);
                      }
                    });

                    Navigator.pop(context);
                  },
                  child: Text(isEdit ? 'Update Order' : 'Add Order',style: TextStyle(color: AppColors.white,),),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterAndSortOrders() {
    List<Map<String, dynamic>> filtered = orders.where((order) {
      final matchesStatus = selectedStatus == 'All' || order['status'] == selectedStatus;
      final matchesSearch = searchQuery.isEmpty ||
          order['user'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          order['id'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();

    switch (selectedSort) {
      case 'Oldest':
        filtered.sort((a, b) => a['date'].compareTo(b['date']));
        break;
      case 'Customer Name':
        filtered.sort((a, b) => a['user'].compareTo(b['user']));
        break;
      default:
        filtered.sort((a, b) => b['date'].compareTo(a['date']));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _filterAndSortOrders();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const Text('Order Management',style: TextStyle(color: AppColors.white),),
        backgroundColor: AppColors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            tooltip: 'Add New Order',
            onPressed: () => _showOrderForm(),
            color: AppColors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search and Filters
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Orders',
                prefixIcon: Icon(Icons.search, color: AppColors.blue),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedStatus,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: ['All', 'Pending', 'Shipped', 'Delivered']
                        .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedStatus = value!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedSort,
                    decoration: const InputDecoration(labelText: 'Sort by'),
                    items: ['Newest', 'Oldest', 'Customer Name']
                        .map((sort) => DropdownMenuItem(value: sort, child: Text(sort)))
                        .toList(),
                    onChanged: (value) => setState(() => selectedSort = value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Order List
            Expanded(
              child: filteredOrders.isEmpty
                  ? const Center(child: Text('No orders found.'))
                  : ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.receipt_long, color: AppColors.blue),
                      title: Text('${order['id']} • ${order['user']}'),
                      subtitle: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall,
                          children: [
                            TextSpan(
                              text: order['status'],
                              style: TextStyle(
                                color: AppColors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: ' — '),
                            TextSpan(
                              text: order['date'].toLocal().toString().split(' ')[0],
                              style: TextStyle(color: AppColors.blue),
                            ),
                          ],
                        ),
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          setState(() {
                            if (value == 'edit') {
                              _showOrderForm(existingOrder: order);
                            } else if (value == 'cancel') {
                              order['status'] = 'Cancelled';
                            } else if (value == 'shipped') {
                              order['status'] = 'Shipped';
                            } else if (value == 'delivered') {
                              order['status'] = 'Delivered';
                            }
                          });
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'edit', child: Text('Edit')),
                          const PopupMenuItem(value: 'shipped', child: Text('Mark as Shipped')),
                          const PopupMenuItem(value: 'delivered', child: Text('Mark as Delivered')),
                          const PopupMenuItem(value: 'cancel', child: Text('Cancel Order')),
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
