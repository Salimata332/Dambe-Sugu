import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  static const routeName = "/help-support";

  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aide & Support"),
        backgroundColor: const Color(0xFFC08457),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Text(
              "Besoin d’aide ?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Contactez-nous :\n\n"
              "📧 Email : support@dambesugu.ml\n"
              "📞 Téléphone : +223 70 00 00 00\n"
              "💬 WhatsApp : +223 70 00 00 00",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
