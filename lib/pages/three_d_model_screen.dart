import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class ThreeDModelScreen extends StatefulWidget {
  final String modelPath;

  const ThreeDModelScreen({super.key, required this.modelPath});

  @override
  State<ThreeDModelScreen> createState() => _ThreeDModelScreenState();
}


class _ThreeDModelScreenState extends State<ThreeDModelScreen> {
  Flutter3DController controller = Flutter3DController();

  @override
  void initState() {
    super.initState();
    controller.onModelLoaded.addListener(() {
      debugPrint('Model loaded: ${controller.onModelLoaded.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xff0d2039),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.close, color: Colors.white),
      //       onPressed: () {
      //         Navigator.of(context).pop(); // Close dialog
      //       },
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.white, Colors.grey],
                stops: [0.1, 1.0],
                radius: 0.7,
                center: Alignment.center,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Flutter3DViewer(
              activeGestureInterceptor: true,
              progressBarColor: Colors.orange,
              enableTouch: true,
              onProgress: (progressValue) {
                debugPrint('Loading progress: $progressValue');
              },
              onLoad: (modelAddress) {
                debugPrint('Loaded model: $modelAddress');
                controller.playAnimation();
              },
              onError: (error) {
                debugPrint('Load error: $error');
              },
              controller: controller,
              src: widget.modelPath,
            ),
          ),
          Positioned(
              right: 0,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close,size: 40,),
              ),
          ),
        ],
      ),
    );
  }
}
