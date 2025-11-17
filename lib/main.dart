import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// ======== IMPORTS DE TES PAGES ========
import 'screens/chat_list_screen.dart';
import 'screens/chat_screen.dart';

// 🔹 Mode de l'application :
// true  → mode Firebase (création de collections, données réelles)
// false → mode maquette (juste affichage UI)
const bool modeFirebase = false;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (modeFirebase) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Si tu veux initialiser ta BD, tu peux décommenter :
    // final baseDonnees = ServiceBaseDonnees();
    // await baseDonnees.initialiserDonnees();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dambe Sugu',
      theme: ThemeData(
        primaryColor: const Color(0xFF8B4513),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B4513)),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B4513),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B4513),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      // 👉 ICI tu choisis la page à afficher
      home: const ChatScreen(personName: 'Test'),
      // Tu peux mettre à la place : ChatListScreen()
      // home: const ChatListScreen(),
    );
  }
}
