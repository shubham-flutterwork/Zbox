import 'package:flutter/material.dart';

import '../constants/color.dart';

class NotificationManagementScreen extends StatefulWidget {
  const NotificationManagementScreen({super.key});

  @override
  State<NotificationManagementScreen> createState() =>
      _NotificationManagementScreenState();
}

class _NotificationManagementScreenState
    extends State<NotificationManagementScreen> {
  final List<String> triggers = [
    "Order Confirmation",
    "Password Reset",
    "Shipping Update",
    "Account Creation"
  ];

  final List<String> placeholders = [
    "{{username}}",
    "{{order_id}}",
    "{{email}}",
    "{{reset_link}}"
  ];

  String selectedTrigger = "Order Confirmation";
  String messageType = "Email"; // or "SMS"

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  void _saveTemplate() {
    String subject = _subjectController.text;
    String body = _bodyController.text;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            '$messageType template for "$selectedTrigger" saved:\n\n$subject\n\n$body')));
  }

  @override
  Widget build(BuildContext context) {
    final isEmail = messageType == "Email";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: const Text("Notification Management",),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Text("Trigger: "),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: selectedTrigger,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedTrigger = value);
                        }
                      },
                      items: triggers
                          .map((t) => DropdownMenuItem(
                          value: t, child: Text(t)))
                          .toList(),
                    ),
                  ],
                ),
                ToggleButtons(
                  isSelected: [messageType == "Email", messageType == "SMS"],
                  onPressed: (index) {
                    setState(() {
                      messageType = index == 0 ? "Email" : "SMS";
                    });
                  },
                  children: const [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text("Email")),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(" SMS ")),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            if (isEmail)
              TextField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: "Subject",
                  border: OutlineInputBorder(),
                ),
              ),
            if (isEmail) const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _bodyController,
                expands: true,
                maxLines: null,
                minLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  labelText: "Message Body",
                  alignLabelWithHint: true,
                  hintText:
                  "Enter message content here...\nUse placeholders like {{username}}, {{order_id}}",
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            // const SizedBox(height: 16),
            // Wrap(
            //   spacing: 8,
            //   children: placeholders
            //       .map((p) => Chip(
            //     label: Text(p),
            //     backgroundColor: Colors.grey[200],
            //   ))
            //       .toList(),
            // ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save Template"),
              onPressed: _saveTemplate,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            )
          ],
        ),
      ),
    );
  }
}
