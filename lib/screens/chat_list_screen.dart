import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Titre supérieur =====
              const Padding(
                padding: EdgeInsets.only(left: 4.0, bottom: 8),
                child: Text(
                  'Listes des conversations',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              // ===== Bande marron (nom + photo) =====
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B4513), // Marron bogolan
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Salimata SOUGANE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        'https://placehold.co/50x50', // 🔁 Remplace par ta photo
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ===== Zone principale =====
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== Colonne d'icônes centrée verticalement =====
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline),
                              color: const Color(0xFF8B4513),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 8),
                            IconButton(
                              icon: const Icon(Icons.notifications_none),
                              color: const Color(0xFF8B4513),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 8),
                            IconButton(
                              icon: const Icon(Icons.bookmark_border),
                              color: const Color(0xFF8B4513),
                              onPressed: () {},
                            ),
                            const SizedBox(height: 8),
                            IconButton(
                              icon: const Icon(Icons.settings_outlined),
                              color: const Color(0xFF8B4513),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // ===== Contenu principal (recherche + bouton + liste) =====
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          // Barre de recherche
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Rechercher',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Bouton "Nouveau message"
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B4513),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Nouveau message',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Liste des conversations
                          Expanded(
                            child: ListView(
                              children: [
                                ConversationCard(
                                  name: 'Salimata',
                                  message:
                                      'Bonjour, besoin d’informations...',
                                  time: '10:35',
                                  unreadCount: 2,
                                  avatarUrl: 'https://placehold.co/50',
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(personName: 'Salimata'),
                                    ),
                                  ),
                                ),
                                ConversationCard(
                                  name: 'Cheickh',
                                  message:
                                      'Salut ! As-tu reçu mon message ?',
                                  time: '09:50',
                                  unreadCount: 1,
                                  avatarUrl: 'https://placehold.co/50',
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(personName: 'Cheickh'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== Widget pour chaque conversation =====
class ConversationCard extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final String avatarUrl;
  final VoidCallback? onTap;

  const ConversationCard({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.unreadCount,
    required this.avatarUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(avatarUrl),
          radius: 24,
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          message,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF8B4513),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
