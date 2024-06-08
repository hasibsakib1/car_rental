import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.nextButtonAction});

  final Function nextButtonAction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        nextButtonAction();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
        foregroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.onPrimary),
        fixedSize: WidgetStateProperty.all(const Size(175, 50)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      child: const Text('Next', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}