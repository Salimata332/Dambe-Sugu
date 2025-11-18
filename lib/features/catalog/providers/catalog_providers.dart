import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CatalogProvider extends ChangeNotifier {
  List<Map<String, dynamic>> products = [];
  bool loading = true;

  Future<void> loadProducts() async {
    loading = true;
    notifyListeners();

    final query = await FirebaseFirestore.instance
        .collection('products')
        .orderBy('createdAt', descending: true)
        .get();

    products = query.docs.map((doc) => doc.data()).toList();

    loading = false;
    notifyListeners();
  }
}
