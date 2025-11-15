import 'package:dambe_sugu/features/profile/pages/help_support_screen.dart';
import 'package:dambe_sugu/features/profile/pages/profile_screen.dart';
import 'package:dambe_sugu/features/profile/pages/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart'; // généré par FlutterFire CLI
import 'pages/login_page.dart';
import 'pages/selection_role_page.dart';
import 'pages/home_buyer.dart';
import 'pages/home_seller.dart';
import 'pages/splash_page.dart';
import 'pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const DambeSuguApp());
}

class DambeSuguApp extends StatelessWidget {
  const DambeSuguApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
        GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingPage()),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(path: '/role', builder: (context, state) => const RoleSelectionPage()),
        GoRoute(path: '/buyer', builder: (context, state) => const HomeBuyer()),
        GoRoute(path: '/seller', builder: (context, state) => const HomeSeller()),
        GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()) ,
        GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
        GoRoute(path: '/help-support', builder: (context, state) => const HelpSupportScreen()),
GoRoute(
  path: '/order-history',
  builder: (context, state) => Scaffold(
    body: Center(
      child: Text('Order history'),
    ),
  ),
),

  
      ],
      redirect: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          return '/onboarding';
        }
        return null;
      },
    );

    return MaterialApp.router(
      title: 'Dambe Sugu',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFC08457),
        scaffoldBackgroundColor: const Color(0xFFFAF3E0),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF1C1C1C)),
        ),
        fontFamily: 'Poppins',
      ),
    );
  }
}
