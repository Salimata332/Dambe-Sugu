import 'package:dambe_sugu/features/catalog/providers/catalog_provider.dart';
import 'package:dambe_sugu/features/catalog/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CatalogProvider>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CatalogProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC08457),
        elevation: 0,
        title: const Text(
          "Catalogue des produits",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Column(
        children: [
          // 🔍 BARRE DE RECHERCHE
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF3E0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFC08457)),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Rechercher un produit...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),

          // CONTENU
          Expanded(
            child: provider.loading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: provider.products[index],
                        onTap: () {},
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
