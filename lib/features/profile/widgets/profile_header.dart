import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: imageUrl != null
              ? NetworkImage(imageUrl!)
              : null,
          child: imageUrl == null ? const Icon(Icons.person, size: 50) : null,
        ),
        const SizedBox(height: 10),
        Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(email, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
