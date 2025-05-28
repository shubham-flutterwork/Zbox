import 'package:flutter/material.dart';
import '../constants/color.dart'; // Your shared colors file
import 'package:zbox_admin/pages/product_details_screen.dart'; // Your product detail screen

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() => _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> products = [
    {
      "images": [
        "https://m.media-amazon.com/images/I/71rwp0sT4bL.jpg",
        "https://m.media-amazon.com/images/I/71hePpVKObL._AC_UF1000,1000_QL80_.jpg",
        "https://5.imimg.com/data5/SELLER/Default/2024/3/405524250/NO/ER/MO/3788898/executive-office-chair-500x500.jpg",
        "https://assets.wfcdn.com/im/92317366/resize-h800-w800%5Ecompr-r85/2185/218522151/Junichiro+Reclining+Office+Chair+with+Massage%2C+Ergonomic+Office+Chair+with+Foot+Rest.jpg"
      ],
      'name': 'Chair',
      'category': 'Furniture',
      'price': 150,
      'status': 'Inactive',
      'image': 'https://ik.imagekit.io/2xkwa8s1i/img/chairs/Images13/WSCHRGRAVIHBNBWYWEGY_LS_1.jpg?tr=w-3840',
      'video': '',
      'supportName': 'Walkmate',
      'supportContact': '98176736432',
      'modelPath': 'assets/models/chair.glb',
      'quantity': 10,
      'sellers': ['FurnitureWorld', 'ChairMasters'],
    },
    {
      "images": [
        "https://pngimg.com/d/laptop_PNG5905.png",
        "https://images-cdn.ubuy.co.in/6511a6f4485ede30f811bc23-hp-15-6-screen-fhd-laptop-computer-amd.jpg",
        "https://i5.walmartimages.com/asr/c969327c-31ca-4f89-b984-5c9d82334a6c.8f2bb748325a96780cb89009bd597602.jpeg",
        "https://i5.walmartimages.com/seo/HP-14-Notebook-14-HD-Touch-Display-Intel-Core-i3-1115G4-Upto-4-1GHz-8GB-RAM-256GB-NVMe-SSD-HDMI-Wi-Fi-Bluetooth-Windows-10-Home-S-420X5UA.jpeg"
      ],
      'name': 'Laptop',
      'category': 'Electronics',
      'price': 999,
      'status': 'Active',
      'image': 'https://pngimg.com/d/laptop_PNG5905.png',
      'video': '',
      'supportName': 'John Support',
      'supportContact': '+1234567890',
      'modelPath': 'assets/models/laptop2.glb',
      'quantity': 5,
      'sellers': ['TechGuru', 'LaptopStore'],
    },
    {
      "images": [
        "https://images.hindustantimes.com/auto/img/2024/12/07/600x338/Mercedes_G-Class_electric.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJms8QUP9YX0zMEO6Ahv-Jrmp",
        "https://images.carandbike.com/car-images/large/mercedes-benz/g-class/mercedes-benz-g-class.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsrNeDRcmUjGdd6Eo6WBfPK84"
      ],
      'name': 'G Wagon',
      'category': 'Cars',
      'price': 99999,
      'status': 'Active',
      'image': 'https://vehicle-images.dealerinspire.com/stock-images/chrome/109f601739797fa27531568a73e236f6.png',
      'video': '',
      'supportName': 'Tony Stark',
      'supportContact': '+9123456780',
      'modelPath': 'assets/models/car.glb',
      'quantity': 2,
      'sellers': ['StarkMotors', 'G-WagonDealers'],
    },
  ];

  void _showProductForm({Map<String, dynamic>? existingProduct}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ProductFormSheet(existingProduct: existingProduct),
    );

    if (result != null) {
      setState(() {
        if (existingProduct != null) {
          final index = products.indexOf(existingProduct);
          products[index] = result;
        } else {
          products.add(result);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return selectedCategory == 'All' || product['category'] == selectedCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Product Management',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: AppColors.white),
            onPressed: () => _showProductForm(),
            tooltip: 'Add New Product',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: 'Filter by Category',
                labelStyle: TextStyle(color: AppColors.red),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
              items: ['All', 'Electronics', 'Clothing', 'Furniture']
                  .map((c) => DropdownMenuItem(
                value: c,
                child: Text(
                  c,
                  style: TextStyle(color: AppColors.blue),
                ),
              ))
                  .toList(),
              onChanged: (v) => setState(() => selectedCategory = v!),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: filteredProducts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: product['image'] != null && product['image'] != ''
                              ? FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: product['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                              : const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                        ),
                        title: Text(
                          product['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.red,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              '${product['category']} • ₹${product['price']}',
                              style: TextStyle(color: AppColors.blue),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Status: ${product['status']}',
                              style: TextStyle(
                                color: product['status'] == 'Active'
                                    ? Colors.green
                                    : Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (product['supportName'] != '')
                              Text(
                                'Support: ${product['supportName']}',
                                style: TextStyle(color: AppColors.blue),
                              ),
                            if (product['supportContact'] != '')
                              Text(
                                'Contact: ${product['supportContact']}',
                                style: TextStyle(color: AppColors.blue),
                              ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert, color: AppColors.blue),
                          onSelected: (value) {
                            if (value == 'edit') {
                              _showProductForm(existingProduct: product);
                            } else if (value == 'deactivate') {
                              setState(() {
                                product['status'] = 'Inactive';
                              });
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'edit', child: Text('Edit')),
                            const PopupMenuItem(value: 'deactivate', child: Text('Deactivate')),
                          ],
                        ),
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

class ProductFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existingProduct;
  const ProductFormSheet({super.key, this.existingProduct});

  @override
  State<ProductFormSheet> createState() => _ProductFormSheetState();
}

class _ProductFormSheetState extends State<ProductFormSheet> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController imageController;
  late TextEditingController videoController;
  late TextEditingController supportNameController;
  late TextEditingController supportContactController;
  late String selectedCategory;
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    final p = widget.existingProduct;
    nameController = TextEditingController(text: p?['name'] ?? '');
    priceController = TextEditingController(text: p?['price']?.toString() ?? '');
    imageController = TextEditingController(text: p?['image'] ?? '');
    videoController = TextEditingController(text: p?['video'] ?? '');
    supportNameController = TextEditingController(text: p?['supportName'] ?? '');
    supportContactController = TextEditingController(text: p?['supportContact'] ?? '');
    selectedCategory = p?['category'] ?? 'Electronics';
    selectedStatus = p?['status'] ?? 'Active';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.existingProduct != null ? 'Edit Product' : 'Add New Product',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.red,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                labelStyle: TextStyle(color: AppColors.red),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
              style: TextStyle(color: AppColors.blue),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(color: AppColors.red),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: AppColors.blue),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: ['Electronics', 'Clothing', 'Furniture']
                  .map((c) => DropdownMenuItem(
                value: c,
                child: Text(
                  c,
                  style: TextStyle(color: AppColors.blue),
                ),
              ))
                  .toList(),
              onChanged: (v) => setState(() => selectedCategory = v!),
              decoration: InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(color: AppColors.red),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: imageController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                labelStyle: TextStyle(color: AppColors.red),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
              style: TextStyle(color: AppColors.blue),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: videoController,
              decoration: InputDecoration(
                labelText: 'Video URL',
                labelStyle: TextStyle(color: AppColors.red),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
              style: TextStyle(color: AppColors.blue),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: supportNameController,
              decoration: InputDecoration(
                labelText: 'Support Name',
                labelStyle: TextStyle(color: AppColors.red),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
              style: TextStyle(color: AppColors.blue),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: supportContactController,
              decoration: InputDecoration(
                labelText: 'Support Contact',
                labelStyle: TextStyle(color: AppColors.red),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
              style: TextStyle(color: AppColors.blue),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              items: ['Active', 'Inactive']
                  .map((status) => DropdownMenuItem(
                value: status,
                child: Text(
                  status,
                  style: TextStyle(color: AppColors.blue),
                ),
              ))
                  .toList(),
              onChanged: (v) => setState(() => selectedStatus = v!),
              decoration: InputDecoration(
                labelText: 'Status',
                labelStyle: TextStyle(color: AppColors.red),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: AppColors.white,
                minimumSize: const Size.fromHeight(45),
              ),
              onPressed: () {
                final newProduct = {
                  'name': nameController.text,
                  'price': double.tryParse(priceController.text) ?? 0,
                  'category': selectedCategory,
                  'image': imageController.text,
                  'video': videoController.text,
                  'supportName': supportNameController.text,
                  'supportContact': supportContactController.text,
                  'status': selectedStatus,
                };
                Navigator.pop(context, newProduct);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
