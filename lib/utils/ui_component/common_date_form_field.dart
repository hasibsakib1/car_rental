import 'package:flutter/material.dart';

class CommonDateFormField extends StatelessWidget {
  const CommonDateFormField({super.key, required this.formTitle, required this.controller});

  final String formTitle;
  final TextEditingController controller;

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
            readOnly: true, // prevent keyboard from showing up
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              suffixIcon: const Icon(Icons.calendar_today_outlined),
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  final dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                  controller.text = dateTime.toIso8601String(); // format the date and time as you want
                }
              }
            },
          ),
        ],
      ),
    );
  }
}