import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceBaseDonnees {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ===========================
  // 🔹 UTILISATEURS (client ou vendeur)
  // ===========================
  Future<void> ajouterUtilisateur({
    required String idUtilisateur,
    required String nom,
    required String email,
    required String telephone,
    required String role, // "client" ou "vendeur"
    String? adresse,
    String? photoUrl,
    String? moyenPaiement,
  }) async {
    await _db.collection('utilisateurs').doc(idUtilisateur).set({
      'id': idUtilisateur,
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'role': role,
      'adresse': adresse ?? '',
      'photoUrl': photoUrl ?? '',
      'moyenPaiement': moyenPaiement ?? '',
      'creeLe': FieldValue.serverTimestamp(),
    });
  }

  // ===========================
  // 🔹 PRODUITS
  // ===========================
  Future<void> ajouterProduit({
    required String idProduit,
    required String idVendeur, // on remplace idBoutique par idVendeur
    required String nom,
    required String description,
    required double prix,
    required List<String> images,
    required String categorie,
    int stock = 1,
  }) async {
    await _db.collection('produits').doc(idProduit).set({
      'id': idProduit,
      'idVendeur': idVendeur,
      'nom': nom,
      'description': description,
      'prix': prix,
      'images': images,
      'stock': stock,
      'categorie': categorie,
      'creeLe': FieldValue.serverTimestamp(),
    });
  }

  // ===========================
  // 🔹 COMMANDES
  // ===========================
  Future<void> ajouterCommande({
    required String idCommande,
    required String idClient,
    required String idVendeur,
    required String idProduit,
    required int quantite,
    required double prixTotal,
    required String moyenPaiement,
  }) async {
    await _db.collection('commandes').doc(idCommande).set({
      'id': idCommande,
      'idClient': idClient,
      'idVendeur': idVendeur,
      'idProduit': idProduit,
      'quantite': quantite,
      'prixTotal': prixTotal,
      'moyenPaiement': moyenPaiement,
      'statut': 'en_attente',
      'statutPaiement': 'non_payé',
      'creeLe': FieldValue.serverTimestamp(),
    });
  }

  // ===========================
  // 🔹 MESSAGES (Chat)
  // ===========================
  Future<void> envoyerMessage({
    required String idDiscussion,
    required String idExpediteur,
    required String idDestinataire,
    required String texte,
  }) async {
    // Conversation
    await _db.collection('messages').doc(idDiscussion).set({
      'utilisateurs': [idExpediteur, idDestinataire],
      'dernierMessage': texte,
      'misAJourLe': FieldValue.serverTimestamp(),
    });

    // Messages (sous collection)
    await _db
        .collection('messages')
        .doc(idDiscussion)
        .collection('discussions')
        .add({
      'idExpediteur': idExpediteur,
      'texte': texte,
      'envoyeLe': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> obtenirMessages(String idDiscussion) {
    return _db
        .collection('messages')
        .doc(idDiscussion)
        .collection('discussions')
        .orderBy('envoyeLe', descending: false)
        .snapshots();
  }

  // ===========================
  // 🔹 NOTIFICATIONS
  // ===========================
  Future<void> ajouterNotification({
    required String idUtilisateur,
    required String titre,
    required String contenu,
  }) async {
    await _db.collection('notifications').add({
      'idUtilisateur': idUtilisateur,
      'titre': titre,
      'contenu': contenu,
      'lu': false,
      'envoyeLe': FieldValue.serverTimestamp(),
    });
  }

  // ===========================
  // 🔹 AVIS
  // ===========================
  Future<void> ajouterAvis({
    required String idUtilisateur,
    required String idProduit,
    required int note,
    required String commentaire,
  }) async {
    await _db.collection('avis').add({
      'idUtilisateur': idUtilisateur,
      'idProduit': idProduit,
      'note': note,
      'commentaire': commentaire,
      'creeLe': FieldValue.serverTimestamp(),
    });
  }

  // ===========================
  // 🔹 MISE À JOUR MOYEN DE PAIEMENT
  // ===========================
  Future<void> mettreAJourMoyenPaiement({
    required String idUtilisateur,
    required String moyenPaiement,
  }) async {
    await _db.collection('utilisateurs').doc(idUtilisateur).update({
      'moyenPaiement': moyenPaiement,
      'misAJourLe': FieldValue.serverTimestamp(),
    });
  }
}
