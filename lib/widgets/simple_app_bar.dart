import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SimpleAppBar({super.key, this.title = ''});

  @override
  Widget build(BuildContext context) => AppBar(title: Text(title));

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
