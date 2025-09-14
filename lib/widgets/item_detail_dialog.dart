import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemDetailDialog extends StatelessWidget {
  final LoLItem item;

  const ItemDetailDialog({super.key, required this.item});

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com imagem, nome, custo e status principal
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFC9AA71),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF463714),
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Color(0xFFC9AA71),
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          color: Color(0xFFC9AA71),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (item.plaintext.isNotEmpty)
                        Text(
                          item.plaintext,
                          style: const TextStyle(
                            color: Color(0xFFA09B8C),
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: Color(0xFFC9AA71),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${item.totalCost}',
                            style: const TextStyle(
                              color: Color(0xFFC9AA71),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (item.sellPrice > 0) ...[
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
                Text(
                  'Construído a partir de: ${item.from.join(', ')}',
                  style: const TextStyle(
                    color: Color(0xFFA09B8C),
                    fontSize: 12,
                  ),
                ),
              if (item.into.isNotEmpty)
                Text(
                  'Usado para construir: ${item.into.join(', ')}',
                  style: const TextStyle(
                    color: Color(0xFFA09B8C),
                    fontSize: 12,
                  ),
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

