import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: double.infinity,
      leading: Row(
        children: [
          TextButton.icon(
            icon: const Icon(Icons.arrow_back_ios),
            label: const Text('Back', style: TextStyle(fontSize: 14)),
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.onSecondary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
