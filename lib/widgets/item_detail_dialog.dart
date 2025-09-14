import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemDetailDialog extends StatelessWidget {
  final LoLItem item;
  final List<LoLItem> allItems;

  const ItemDetailDialog({super.key, required this.item, required this.allItems});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1E2328),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFFC9AA71),
          width: 2,
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ...existing code...
            ],
          ),
        ),
      ),
    );
  }
}

// ...existing code...
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.sell,
                              color: Color(0xFFA09B8C),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${item.sellPrice}',
                              style: const TextStyle(
                                color: Color(0xFFA09B8C),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Descrição detalhada
            if (item.cleanDescription.isNotEmpty) ...[
              const Text(
                'Descrição:',
                style: TextStyle(
                  color: Color(0xFFC9AA71),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF3C3C41),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF5BC0DE),
                    width: 1,
                  ),
                ),
                child: Text(
                  item.cleanDescription,
                  style: const TextStyle(
                    color: Color(0xFFF0E6D2),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Status principais
            if (item.mainStats.isNotEmpty) ...[
              const Text(
                'Atributos:',
                style: TextStyle(
                  color: Color(0xFFC9AA71),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF3C3C41),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF0596AA),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item.mainStats.map((stat) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• $stat',
                      style: const TextStyle(
                        color: Color(0xFF0596AA),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Categorias/tags
            if (item.tags.isNotEmpty) ...[
              const Text(
                'Categorias:',
                style: TextStyle(
                  color: Color(0xFFC9AA71),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: item.tags.map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF463714),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFC9AA71),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xFFC9AA71),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 16),
            ],
            
            // Build path info
            if (item.from.isNotEmpty || item.into.isNotEmpty) ...[
              const Text(
                'Receita:',
                style: TextStyle(
                  color: Color(0xFFC9AA71),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (item.from.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Construído a partir de:', style: TextStyle(color: Color(0xFFA09B8C), fontSize: 12)),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      children: item.from.map((id) {
                        final found = allItems.firstWhere((i) => i.id == id, orElse: () => LoLItem(
                          id: id,
                          name: id,
                          description: '',
                          plaintext: '',
                          image: '',
                          totalCost: 0,
                          sellPrice: 0,
                          purchasable: false,
                          tags: [],
                          stats: {},
                          from: [],
                          into: [],
                        ));
                        return Column(
                          children: [
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: found.image.isNotEmpty
                                  ? Image.network(found.imageUrl, errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported, size: 16))
                                  : const Icon(Icons.image_not_supported, size: 16),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(found.name, style: const TextStyle(fontSize: 10, color: Color(0xFFC9AA71)), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              if (item.into.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text('Usado para construir:', style: TextStyle(color: Color(0xFFA09B8C), fontSize: 12)),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      children: item.into.map((id) {
                        final found = allItems.firstWhere((i) => i.id == id, orElse: () => LoLItem(
                          id: id,
                          name: id,
                          description: '',
                          plaintext: '',
                          image: '',
                          totalCost: 0,
                          sellPrice: 0,
                          purchasable: false,
                          tags: [],
                          stats: {},
                          from: [],
                          into: [],
                        ));
                        return Column(
                          children: [
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: found.image.isNotEmpty
                                  ? Image.network(found.imageUrl, errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported, size: 16))
                                  : const Icon(Icons.image_not_supported, size: 16),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(found.name, style: const TextStyle(fontSize: 10, color: Color(0xFFC9AA71)), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
            ],
            
            // Close button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC9AA71),
                  foregroundColor: const Color(0xFF0F2027),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Fechar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

