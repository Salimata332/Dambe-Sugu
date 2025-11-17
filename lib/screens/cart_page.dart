Alou Gueye, [16/11/2025 23:24]
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A1C14), // Fond marron foncé
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ---- HEADER ----
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    "Mon Panier",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ---- ITEM 1 ----
              _cartItem(
                image: Icons.checkroom,
                title: "Robe en coton",
                price: "8 500 F CFA",
              ),

              const SizedBox(height: 20),

              // ---- ITEM 2 ----
              _cartItem(
                image: Icons.shopping_bag,
                title: "Chaussures",
                price: "3 000 F CFA",
              ),

              const SizedBox(height: 40),

              const Divider(color: Colors.white24),

              const SizedBox(height: 20),

              // ---- RÉCAP ----
              _recapRow("Sous-total", "8 500 FCFA"),
              const SizedBox(height: 10),
              _recapRow("Livraison", "Gratuite"),
              const SizedBox(height: 10),
              _recapRow(
                "Total",
                "8 500 FCFA",
                highlight: true,
              ),

              const Spacer(),

              // ---- BOUTON ----
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C5F2B),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Valider la commande",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  // ---- WIDGET ITEM ----
  Widget _cartItem({
    required IconData image,
    required String title,
    required String price,
  }) {
    return Row(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: const Color(0xFFAD7A4C),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(image, color: Colors.white, size: 30),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                color: Color(0xFFCE8E44),
                fontSize: 16,
              ),
            ),
          ],
        ),
        const Spacer(),
        // ----- QUANTITÉ -----
        Row(
          children: [

Alou Gueye, [16/11/2025 23:24]
_countButton(Icons.remove),
            const SizedBox(width: 10),
            _countButton(Icons.add),
          ],
        )
      ],
    );
  }

  // ---- BOUTON QUANTITÉ ----
  Widget _countButton(IconData icon) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF3D2B1F),
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: Colors.white),
    );
  }

  // ---- RÉCAP ----
  Widget _recapRow(String title, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: highlight ? const Color(0xFFCE8E44) : Colors.white,
            fontSize: 16,
            fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}