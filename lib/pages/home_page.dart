import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dambe_sugu/widgets/custom_button.dart';
import 'package:dambe_sugu/widgets/simple_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Accueil'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Bienvenue — Les collections de test ont été créées dans Firestore !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            CustomButton(
              onPressed: () => context.push('/login'),
              label: 'Aller à la page de connexion',
            ),
          ],
        ),
      ),
    );
  }
}
