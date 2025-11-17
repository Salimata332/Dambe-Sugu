import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    final user = FirebaseAuth.instance.currentUser;
    if (!mounted) return;
    if (user == null) {
      context.go('/onboarding');
    } else {
      context.go('/role');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Try to load the Lottie asset; if missing or fails, show a spinner as fallback.
        child: FutureBuilder<ByteData>(
          future: rootBundle.load('assets/animations/loading.json'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              final bytes = snapshot.data!.buffer.asUint8List();
              return LottieBuilder.memory(bytes, width: 200, height: 200, fit: BoxFit.contain);
            }
            // Fallback UI when asset is missing or failed to load
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 12),
                Text('Chargement...'),
              ],
            );
          },
        ),
      ),
    );
  }
}
