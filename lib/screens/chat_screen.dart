import 'package:flutter/material.dart';

// Les couleurs sont ajustées
const Color _primaryBrown = Color(0xFF6B4226); // Marron foncé pour la barre
const Color _lightBrownBackground = Color(0xFFE0C4A4); // Arrière-plan de la zone de chat (Couleur Opaque)
const Color _darkPatternBackground = Color(0xFF3E2A19); // Couleur utilisée en cas de motif non chargé
// NOUVELLE COULEUR THÈME pour les messages "Moi" : Un Beige Chaud et plus foncé
const Color _myMessageColor = Color(0xFFDCC8B3); 
const Color _otherMessageColor = Colors.white; // Couleur pour les messages "Pas Moi"

// URL d'image de bogolan (RAPPEL : à remplacer par votre asset local si nécessaire)
const String _bogolanImageUrl = 
    "assets/images/bogolan.png"; 

class ChatScreen extends StatefulWidget {
  final String personName;

  const ChatScreen({super.key, this.personName = "Awa SOUGANE"});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {"text": "Bonjour, merci pour tout!", "isMe": false}, 
    {"text": "Bonjour, pouvez-vous me confirmer la date de livraison?", "isMe": true},
  ];

  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "text": controller.text,
        "isMe": true,
      });
    });

    controller.clear();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Laisse le fond du Scaffold au cas où l'image ne charge pas
      backgroundColor: _darkPatternBackground,
      
      body: Stack(
        children: [
          // 1. FOND AVEC LE MOTIF BOGOLAN (maintenant visible)
          Container(
            decoration: BoxDecoration(
              color: _darkPatternBackground, // Couleur de secours
              image: const DecorationImage(
                image: AssetImage(_bogolanImageUrl),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // 2. HEADER
                _buildHeader(widget.personName),

                // 3. MESSAGES AREA (La zone de message devient transparente)
                Expanded(
                  child: Container(
                    // La couleur est rendue transparente pour laisser voir le bogolan
                    color: Colors.transparent, 
                    
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        return Align(
                          alignment: msg["isMe"] ? Alignment.centerRight : Alignment.centerLeft,
                          child: ChatBubble(
                            text: msg["text"],
                            isMe: msg["isMe"],
                            bubbleColor: msg["isMe"] ? _myMessageColor : _otherMessageColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // 4. MESSAGE BAR
                _buildMessageBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String personName) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 16),
      color: _primaryBrown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage("https://i.imgur.com/n1hX6tQ.png"),
                backgroundColor: Colors.white,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    personName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "En ligne",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          
          Row(
            children: const [
              Icon(Icons.notifications_none, color: Colors.white, size: 24),
              SizedBox(width: 10),
              Icon(Icons.more_vert, color: Colors.white, size: 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBar() {
    return Container(
      color: _primaryBrown,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(Icons.attach_file, color: Colors.white),
          const SizedBox(width: 10),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              // CORRECTION: Assurez-vous qu'il n'y a pas d'espace insécable ici (ligne 239)
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: controller,
                onSubmitted: (_) => sendMessage(),
                decoration: const InputDecoration(
                  hintText: "Écrire un message...",
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.sentiment_satisfied_alt_outlined, color: Colors.grey),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          GestureDetector(
            onTap: sendMessage,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.send, color: Color(0xFF8B4513)),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final Color bubbleColor;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.bubbleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8), 
      
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      
      child: Container(
        padding: const EdgeInsets.all(10), 
        decoration: BoxDecoration(
          color: bubbleColor, 
          borderRadius: BorderRadius.only(
            // Coins supérieurs toujours arrondis
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            // Coin pour le 'bec' mis à zéro pour un look plus prononcé
            // Si 'isMe' est vrai (moi), le 'bec' est en bas à droite (Radius.zero)
            bottomLeft: isMe ? const Radius.circular(12) : Radius.zero,
            // Si 'isMe' est faux (autre), le 'bec' est en bas à gauche (Radius.zero)
            bottomRight: isMe ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}