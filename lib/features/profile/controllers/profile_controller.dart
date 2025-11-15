import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<DocumentSnapshot> getUserProfile() async {
    return await _db.collection('users').doc(currentUser!.uid).get();
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    await _db.collection('users').doc(currentUser!.uid).update(data);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
