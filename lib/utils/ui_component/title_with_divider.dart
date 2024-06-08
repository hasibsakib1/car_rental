import 'package:flutter/material.dart';

class TitleWithDivider extends StatelessWidget {
  const TitleWithDivider({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.primary,
          thickness: 2,
        ),
      ],
    );
  }
}