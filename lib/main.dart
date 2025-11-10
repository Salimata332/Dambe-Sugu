import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart'; // généré automatiquement par FlutterFire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _message = 'Chargement...';

  @override
  void initState() {
    super.initState();
    _readDataFromFirestore();
  }

  // Lire un document Firestore
  Future<void> _readDataFromFirestore() async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('test').doc('message').get();

      if (snapshot.exists) {
        setState(() {
          _message = snapshot['text'] ?? 'Aucun texte trouvé';
        });
      } else {
        setState(() {
          _message = 'Document non trouvé';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Erreur: $e';
      });
    }
  }

  // Écrire un document Firestore
  Future<void> _writeDataToFirestore() async {
    try {
      await _firestore.collection('test').doc('message').set({
        'text': 'Hello Firebase ${DateTime.now()}',
      });
      _readDataFromFirestore(); // rafraîchir
    } catch (e) {
      setState(() {
        _message = 'Erreur écriture: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Firebase Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _message,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _writeDataToFirestore,
              child: const Text('Écrire dans Firestore'),
            ),
          ],
        ),
      ),
    );
  }
}
