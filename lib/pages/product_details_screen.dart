import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/color.dart'; // your shared colors file
import 'three_d_model_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  PageController? _pageController;
  int _currentPage = 0;
  List<String> _imageUrls = [];
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();

    _imageUrls = (widget.product['images'] ?? []).cast<String>();
    if (_imageUrls.isEmpty && widget.product['image'] != null && widget.product['image'] != '') {
      _imageUrls = [widget.product['image']];
    }

    _pageController = PageController();

    if (_imageUrls.length > 1) {
      _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        if (_pageController != null && _pageController!.hasClients) {
          _currentPage = (_currentPage + 1) % _imageUrls.length;
          _pageController!.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          product['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.white, // white appbar text
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.threed_rotation, size: 30),
            tooltip: '360° View',
            color: AppColors.white, // red icon for 3D view
            onPressed: () {
              final modelPath = product['modelPath'] ?? '';
              if (modelPath.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    insetPadding: const EdgeInsets.all(16),
                    child: SizedBox(
                      height: 400,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ThreeDModelScreen(modelPath: modelPath),
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No 3D model available for this product.')),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_imageUrls.isNotEmpty && _pageController != null) ...[
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController!,
                    itemCount: _imageUrls.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          _imageUrls[index],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(_imageUrls.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: _currentPage == index ? 12.0 : 8.0,
                        height: _currentPage == index ? 12.0 : 8.0,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? AppColors.blue : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),
              ],
              const SizedBox(height: 16),

              // Headings in Red
              Text(
                'Category: ${product['category']}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.red),
              ),
              const SizedBox(height: 8),

              // Price in Blue (general info)
              Text(
                'Price: ₹${product['price']}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.blue),
              ),
              const SizedBox(height: 8),

              // Status in Black italics
              Text(
                'Status: ${product['status']}',
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.black),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Text('Quantity:', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.red)),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    color: Colors.black,
                    onPressed: _decrementQuantity,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('$quantity', style: const TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: Colors.black,
                    onPressed: _incrementQuantity,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              if (product['sellers'] != null && product['sellers'].isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Sellers/Vendors:',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.red),
                    ),
                    const SizedBox(height: 8),
                    for (var seller in product['sellers'])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(seller, style: const TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                  ],
                ),

              const SizedBox(height: 10),

              if (product['video'] != '')
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Video'),
                        content: Text('Video URL: ${product['video']}'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.video_library, color: AppColors.blue),
                      SizedBox(width: 8),
                      Text('Watch Video', style: TextStyle(color: AppColors.blue, fontSize: 16)),
                    ],
                  ),
                ),

              const SizedBox(height: 10),

              if (product['supportName'] != '')
                Text('Support Name: ${product['supportName']}', style: const TextStyle(fontSize: 16, color: Colors.black)),

              if (product['supportContact'] != '')
                Text('Support Contact: ${product['supportContact']}', style: const TextStyle(fontSize: 16, color: Colors.black)),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
