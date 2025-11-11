import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceBaseDonnees {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ===========================
  // 🔹 UTILISATEURS
  // ===========================
  Future<void> ajouterUtilisateur({
    required String idUtilisateur,
    required String nom,
    required String email,
    required String telephone,
    required String role,
    String? adresse,
    String? photoUrl,
    String? moyenPaiement,
  }) async {
    try {
      await _db.collection('utilisateurs').doc(idUtilisateur).set({
        'id': idUtilisateur,
        'nom': nom,
        'email': email,
        'telephone': telephone,
        'role': role,
        'adresse': adresse ?? '',
        'photoUrl': photoUrl ?? '',
        'moyenPaiement': moyenPaiement ?? '',
        'favoris': [],
        'creeLe': FieldValue.serverTimestamp(),
      });
      print('✅ Utilisateur $idUtilisateur ajouté');
    } catch (e) {
      print('❌ Erreur ajout utilisateur $idUtilisateur : $e');
    }
  }

  // ===========================
  // 🔹 VENDEURS
  // ===========================
  Future<void> ajouterVendeur({
    required String idVendeur,
    required String nomBoutique,
    required String description,
    required String region,
  }) async {
    try {
      await _db.collection('vendeurs').doc(idVendeur).set({
        'id': idVendeur,
        'nomBoutique': nomBoutique,
        'description': description,
        'region': region,
        'chiffreAffaires': 0,
        'note': 0,
        'creeLe': FieldValue.serverTimestamp(),
      });
      print('✅ Vendeur $idVendeur ajouté');
    } catch (e) {
      print('❌ Erreur ajout vendeur $idVendeur : $e');
    }
  }

  // ===========================
  // 🔹 PRODUITS
  // ===========================
  Future<void> ajouterProduit({
    required String idProduit,
    required String idVendeur,
    required String nom,
    required String description,
    required double prix,
    required List<String> images,
    required String categorie,
    int stock = 1,
  }) async {
    try {
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
      print('✅ Produit $idProduit ajouté');
    } catch (e) {
      print('❌ Erreur ajout produit $idProduit : $e');
    }
  }

  // ===========================
  // 🔹 COMMANDES
  // ===========================
  Future<void> ajouterCommande({
    required String idCommande,
    required String idUtilisateur,
    required String idVendeur,
    required String idProduit,
    required int quantite,
    required double prixTotal,
    required String moyenPaiement,
  }) async {
    try {
      await _db.collection('commandes').doc(idCommande).set({
        'id': idCommande,
        'idUtilisateur': idUtilisateur,
        'idVendeur': idVendeur,
        'idProduit': idProduit,
        'quantite': quantite,
        'statut': 'en_attente',
        'prixTotal': prixTotal,
        'moyenPaiement': moyenPaiement,
        'statutPaiement': 'non_payé',
        'creeLe': FieldValue.serverTimestamp(),
      });
      print('✅ Commande $idCommande ajoutée');
    } catch (e) {
      print('❌ Erreur ajout commande $idCommande : $e');
    }
  }

  // ===========================
  // 🔹 MESSAGES
  // ===========================
  Future<void> envoyerMessage({
    required String idDiscussion,
    required String idExpediteur,
    required String idDestinataire,
    required String texte,
  }) async {
    try {
      // Conversation principale
      await _db.collection('messages').doc(idDiscussion).set({
        'utilisateurs': [idExpediteur, idDestinataire],
        'dernierMessage': texte,
        'misAJourLe': FieldValue.serverTimestamp(),
      });

      // Sous-collection de messages
      await _db
          .collection('messages')
          .doc(idDiscussion)
          .collection('discussions')
          .add({
        'idExpediteur': idExpediteur,
        'texte': texte,
        'envoyeLe': FieldValue.serverTimestamp(),
      });
      print('✅ Message dans $idDiscussion ajouté');
    } catch (e) {
      print('❌ Erreur envoi message $idDiscussion : $e');
    }
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
    try {
      await _db.collection('notifications').add({
        'idUtilisateur': idUtilisateur,
        'titre': titre,
        'contenu': contenu,
        'lu': false,
        'envoyeLe': FieldValue.serverTimestamp(),
      });
      print('✅ Notification pour $idUtilisateur ajoutée');
    } catch (e) {
      print('❌ Erreur ajout notification : $e');
    }
  }

  // ===========================
  // 🔹 AVIS / NOTES
  // ===========================
  Future<void> ajouterAvis({
    required String idUtilisateur,
    required String idProduit,
    required int note,
    required String commentaire,
  }) async {
    try {
      await _db.collection('avis').add({
        'idUtilisateur': idUtilisateur,
        'idProduit': idProduit,
        'note': note,
        'commentaire': commentaire,
        'creeLe': FieldValue.serverTimestamp(),
      });
      print('✅ Avis pour $idProduit ajouté');
    } catch (e) {
      print('❌ Erreur ajout avis : $e');
    }
  }
    // ===========================
  // 🔹 INITIALISATION DES DONNÉES DE TEST
  // ===========================
  Future<void> initialiserDonnees() async {
    try {
      // --- UTILISATEUR ---
      await ajouterUtilisateur(
        idUtilisateur: 'user001',
        nom: 'Salimata Sougane',
        email: 'salimata@example.com',
        telephone: '+22370000000',
        role: 'acheteur',
      );

      // --- VENDEUR ---
      await ajouterVendeur(
        idVendeur: 'vendeur001',
        nomBoutique: 'Boutique Test',
        description: 'Description de la boutique test',
        region: 'Bamako',
      );

      // --- PRODUIT ---
      await ajouterProduit(
        idProduit: 'produit001',
        idVendeur: 'vendeur001',
        nom: 'Produit Test',
        description: 'Description du produit test',
        prix: 1500.0,
        images: ['https://example.com/image.jpg'],
        categorie: 'Catégorie test',
        stock: 10,
      );

      // --- COMMANDE ---
      await ajouterCommande(
        idCommande: 'commande001',
        idUtilisateur: 'user001',
        idVendeur: 'vendeur001',
        idProduit: 'produit001',
        quantite: 2,
        prixTotal: 3000.0,
        moyenPaiement: 'Mobile Money',
      );

      // --- MESSAGE ---
      await envoyerMessage(
        idDiscussion: 'discussion001',
        idExpediteur: 'user001',
        idDestinataire: 'vendeur001',
        texte: 'Bonjour, je suis intéressé par votre produit.',
      );

      // --- NOTIFICATION ---
      await ajouterNotification(
        idUtilisateur: 'user001',
        titre: 'Bienvenue',
        contenu: 'Bienvenue sur notre plateforme !',
      );

      // --- AVIS ---
      await ajouterAvis(
        idUtilisateur: 'user001',
        idProduit: 'produit001',
        note: 5,
        commentaire: 'Excellent produit, très satisfait !',
      );

      print('✅ Initialisation des données de test terminée !');

    } catch (e) {
      print('❌ Erreur lors de l’initialisation des données : $e');
    }
  }


  // ===========================
  // 🔹 LECTURES RAPIDES
  // ===========================
  Stream<QuerySnapshot> obtenirProduits() =>
      _db.collection('produits').orderBy('creeLe', descending: true).snapshots();

  Stream<QuerySnapshot> obtenirCommandesUtilisateur(String idUtilisateur) =>
      _db.collection('commandes').where('idUtilisateur', isEqualTo: idUtilisateur).snapshots();

  Stream<QuerySnapshot> obtenirCommandesVendeur(String idVendeur) =>
      _db.collection('commandes').where('idVendeur', isEqualTo: idVendeur).snapshots();
}
