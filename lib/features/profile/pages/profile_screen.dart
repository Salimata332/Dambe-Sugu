import 'package:flutter/material.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = ProfileController();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    final doc = await controller.getUserProfile();
    setState(() => userData = doc.data() as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Profil"),
        backgroundColor: const Color(0xFFC08457),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ProfileHeader(
            name: userData!['name'] ?? "",
            email: userData!['email'] ?? "",
            imageUrl: userData!['photo'],
          ),
          const SizedBox(height: 20),

          SettingsTile(
            icon: Icons.history,
            title: "Historique des commandes",
            onTap: () => Navigator.pushNamed(context, "/order-history"),
          ),
          SettingsTile(
            icon: Icons.settings,
            title: "Paramètres",
            onTap: () => Navigator.pushNamed(context, "/settings"),
          ),
          SettingsTile(
            icon: Icons.help_outline,
            title: "Aide & Support",
            onTap: () => Navigator.pushNamed(context, "/help-support"),
          ),
          SettingsTile(
            icon: Icons.logout,
            title: "Déconnexion",
            onTap: () async {
              await controller.logout();
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
    );
  }
}