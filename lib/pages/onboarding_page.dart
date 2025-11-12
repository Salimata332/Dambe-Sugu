import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      body: PageView(
        children: [
          _buildPage(
            context,
            "Découvrez la mode malienne",
            "Explorez les plus beaux habits traditionnels et modernes.",
          ),
          _buildPage(
            context,
            "Soutenez les artisans locaux",
            "Chaque achat aide un créateur à partager son savoir-faire.",
          ),
          _buildPage(
            context,
            "Rejoignez la communauté",
            "Exprimez votre style avec fierté et authenticité.",
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, String title, String description, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text(description, textAlign: TextAlign.center),
          const SizedBox(height: 40),
          if (isLast)
            ElevatedButton(
              onPressed: () => context.go('/login'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC08457)),
              child: const Text("Commencer"),
            ),
        ],
      ),
    );
  }
}
