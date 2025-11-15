import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        backgroundColor: const Color(0xFFC08457),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Langue"),
            subtitle: const Text("Français"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          SwitchListTile(
            title: const Text("Mode sombre"),
            value: false,
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }
}
