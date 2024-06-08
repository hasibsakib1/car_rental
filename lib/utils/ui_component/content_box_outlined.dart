import 'package:flutter/material.dart';

class ContentBoxOutlined extends StatelessWidget {
  const ContentBoxOutlined({super.key, required this.child, this.isChangeSummary = false});

  final Widget child;
  final bool isChangeSummary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isChangeSummary? Theme.of(context).colorScheme.outline : null,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: isChangeSummary? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}