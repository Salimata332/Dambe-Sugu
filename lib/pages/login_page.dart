import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dambe_sugu/widgets/custom_button.dart';
import 'package:dambe_sugu/widgets/simple_app_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Connexion'),
      body: Center(
        child: CustomButton(
          onPressed: () {
            // Exemple: naviguer vers l'accueil
            context.go('/');
          },
          label: 'Se connecter (exemple)',
        ),
      ),
    );
  }
}
