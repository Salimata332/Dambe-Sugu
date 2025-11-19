import 'package:dambe_sugu/features/catalog/pages/catalog_page.dart';
import 'package:dambe_sugu/features/profile/pages/help_support_screen.dart';
import 'package:dambe_sugu/features/profile/pages/profile_screen.dart';
import 'package:dambe_sugu/features/profile/pages/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Fichiers générés
import 'firebase_options.dart';

// Pages d'Authentification et de Navigation (Authentification Branch)
import 'pages/login_page.dart';
import 'pages/selection_role_page.dart';
import 'pages/home_buyer.dart';
import 'pages/home_seller.dart';
import 'pages/splash_page.dart';
import 'pages/onboarding_page.dart';

// Pages de Chat (Messagerie Branch)
import 'screens/chat_list_screen.dart';
import 'screens/chat_screen.dart';


void main() async {
  // Initialisation unique des bindings Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation unique de Firebase (toujours nécessaire pour l'authentification)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const DambeSuguApp());
}

// Composant principal de l'application
class DambeSuguApp extends StatelessWidget {
  const DambeSuguApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    // 🎨 Thème réutilisé de la branche Authentification
    final appTheme = ThemeData(
      primaryColor: const Color(0xFF8B4513), // Couleur Marron Principal
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
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Color(0xFF1C1C1C)),
      ),
      fontFamily: 'Poppins',
    );

  
    // 🛣️ Configuration de GoRouter avec les routes de l'Auth et du Chat
    final GoRouter router = GoRouter(
      // La première page à charger est le Splash Screen
      initialLocation: '/splash', 
      
      routes: [
        // Routes d'Authentification
        GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
        GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingPage()),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(path: '/role', builder: (context, state) => const RoleSelectionPage()),
        GoRoute(path: '/buyer', builder: (context, state) => const HomeBuyer()),
        GoRoute(path: '/seller', builder: (context, state) => const HomeSeller()),
        GoRoute(path: '/catalog', builder: (context, state) => const CatalogPage()),
      ],
      redirect: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        final loggedIn = user != null;
        final isLoggingIn = state.matchedLocation == '/login';
        final isSplashing = state.matchedLocation == '/splash';
        
        // Si l'utilisateur n'est pas connecté et n'est pas déjà en train d'atterrir
        if (!loggedIn && !isSplashing && !isLoggingIn) {
          return '/onboarding';
        }
        
        // Si l'utilisateur est connecté mais essaie d'aller sur la page de connexion/onboarding
        if (loggedIn && (isLoggingIn || state.matchedLocation == '/onboarding')) {
          // Vous devriez rediriger l'utilisateur vers une page d'accueil par défaut (par exemple, /role ou /chats)
          // Pour l'instant, on laisse null pour l'autoriser à continuer s'il est déjà sur une page interne.
          return null; 
        }

        // Laissez l'utilisateur où il veut s'il est loggé, ou redirigez vers l'onboarding si non loggé.
        return null;
      },
    );
    
    // Utilisation de MaterialApp.router pour intégrer GoRouter
    // Utilisation de MaterialApp.router pour intégrer GoRouter
    return MaterialApp.router(
      title: 'Dambe Sugu',
      routerConfig: router,
      theme: appTheme,
    );
  }
}