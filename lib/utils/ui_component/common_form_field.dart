import 'package:flutter/material.dart';

class CommonFormField extends StatelessWidget {
  const CommonFormField({super.key, required this.formTitle, required this.controller, this.isDigitsOnly = false});

  final String formTitle;
  final TextEditingController controller;
  final bool isDigitsOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formTitle,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: isDigitsOnly? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}