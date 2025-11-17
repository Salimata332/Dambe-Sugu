import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Choisissez votre rôle",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => context.go('/buyer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC08457),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text("Je suis un acheteur"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => context.go('/seller'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              icon: const Icon(Icons.storefront_outlined),
              label: const Text("Je suis un vendeur"),
            ),
          ],
        ),
      ),
    );
  }
}
