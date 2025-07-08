import 'package:flutter/material.dart';

import '../constants/color.dart';

class EditorScreen extends StatefulWidget {
  final String pageTitle;

  const EditorScreen({Key? key, required this.pageTitle}) : super(key: key);

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final TextEditingController _controller = TextEditingController();

  void _saveContent() {
    final content = _controller.text;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.pageTitle} saved:\n$content')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: Text("Edit ${widget.pageTitle}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: TextField(
                controller: _controller,
                expands: true,
                maxLines: null,
                minLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Enter ${widget.pageTitle} content...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Save Button
            ElevatedButton.icon(
              onPressed: _saveContent,
              icon: const Icon(Icons.save),
              label: const Text("Save"),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
