// lib/models/product_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String idProduit;
  final String idVendeur;
  final String description;
  final double prix;
  final String images;
  final String nom;
  final String categorie;
  
  // ignore: prefer_typing_uninitialized_variables
  var published;

  ProductModel({
    required this.idProduit,
    required this.nom,
    required this.description,
    required this.prix,
    required this.images,
    required this.idVendeur,
    required this.categorie,
    this.published = true,
  });

  factory ProductModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      idProduit: doc.id,
      nom: data['title'] ?? '',
      description: data['description'] ?? '',
      prix: (data['price'] ?? 0).toDouble(),
      images: data['imageUrl'] ?? '',
      idVendeur: data['vendorId'] ?? '',
      categorie: data['category'] ?? '',
      published: data['published'] ?? true,
    );
  }

  Map<String, dynamic> toMap() => {
        'nom': nom,
        'description': description,
        'prix': prix,
        'images': images,
        'idVendeur': idVendeur,
        'categorie': categorie,
        'published': published,
        'updatedAt': FieldValue.serverTimestamp(),
      };
}
