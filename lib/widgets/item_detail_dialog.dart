import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemDetailDialog extends StatelessWidget {
  final LoLItem item;
  final List<LoLItem> allItems;

  const ItemDetailDialog({super.key, required this.item, required this.allItems});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFF1E2328),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Color(0xFFC9AA71),
          width: 2,
        ),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 500, maxHeight: 600),
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho: imagem, nome, custo
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFFC9AA71),
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
                            color: Color(0xFF463714),
                            child: Icon(
                              Icons.image_not_supported,
                              color: Color(0xFFC9AA71),
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            color: Color(0xFFC9AA71),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        if (item.plaintext.isNotEmpty)
                          Text(
                            item.plaintext,
                            style: TextStyle(
                              color: Color(0xFFA09B8C),
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Color(0xFFC9AA71),
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${item.totalCost}',
                              style: TextStyle(
                                color: Color(0xFFC9AA71),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (item.sellPrice > 0) ...[
                              SizedBox(width: 16),
                              Icon(Icons.sell, color: Color(0xFFA09B8C), size: 16),
                              SizedBox(width: 4),
                              Text(
                                '${item.sellPrice}',
                                style: TextStyle(
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
              SizedBox(height: 24),
              // Descrição
              if (item.cleanDescription.isNotEmpty) ...[
                Text(
                  'Descrição:',
                  style: TextStyle(
                    color: Color(0xFFC9AA71),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF3C3C41),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFF5BC0DE),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    formatDescription(item.cleanDescription),
                    style: TextStyle(
                      color: Color(0xFFF0E6D2),
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
              // Atributos
              if (item.mainStats.isNotEmpty) ...[
                Text(
                  'Atributos:',
                  style: TextStyle(
                    color: Color(0xFFC9AA71),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF3C3C41),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFF0596AA),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: item.mainStats.map((stat) => Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        '• $stat',
                        style: TextStyle(
                          color: Color(0xFF0596AA),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(height: 16),
              ],
              // Categorias
              if (item.tags.isNotEmpty) ...[
                Text(
                  'Categorias:',
                  style: TextStyle(
                    color: Color(0xFFC9AA71),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: item.tags.map((tag) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF463714),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Color(0xFFC9AA71),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      formatCategory(tag),
                      style: TextStyle(
                        color: Color(0xFFC9AA71),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
                SizedBox(height: 16),
              ],
              // Receita
              if (item.from.isNotEmpty || item.into.isNotEmpty) ...[
                Text(
                  'Receita:',
                  style: TextStyle(
                    color: Color(0xFFC9AA71),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                if (item.from.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Construído a partir de:', style: TextStyle(color: Color(0xFFA09B8C), fontSize: 12)),
                      SizedBox(height: 4),
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
                                    ? Image.network(found.imageUrl, errorBuilder: (c, e, s) => Icon(Icons.image_not_supported, size: 16))
                                    : Icon(Icons.image_not_supported, size: 16),
                              ),
                              SizedBox(
                                width: 60,
                                child: Text(found.name, style: TextStyle(fontSize: 10, color: Color(0xFFC9AA71)), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
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
                      SizedBox(height: 8),
                      Text('Usado para construir:', style: TextStyle(color: Color(0xFFA09B8C), fontSize: 12)),
                      SizedBox(height: 4),
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
                                    ? Image.network(found.imageUrl, errorBuilder: (c, e, s) => Icon(Icons.image_not_supported, size: 16))
                                    : Icon(Icons.image_not_supported, size: 16),
                              ),
                              SizedBox(
                                width: 60,
                                child: Text(found.name, style: TextStyle(fontSize: 10, color: Color(0xFFC9AA71)), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                SizedBox(height: 16),
              ],
              // Botão fechar
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC9AA71),
                    foregroundColor: Color(0xFF0F2027),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Fechar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Função para melhorar a formatação da descrição
String formatDescription(String desc) {
  // Passivas e efeitos destacados
  final passivas = ['Fascínio', 'Ativo', 'Carga de Mana', 'Passivo', 'Desafiar'];
  String result = desc;
  // Destaca passivas e efeitos
  for (final p in passivas) {
    result = result.replaceAll(p, '\n\n$p:');
  }
  // Quebra em linhas para separar atributos e efeitos
  List<String> partes = result.split(RegExp(r'\.|\n'));
  List<String> formatadas = [];
  for (var parte in partes) {
    parte = parte.trim();
    if (parte.isEmpty) continue;
    // Remove vírgulas desnecessárias
    parte = parte.replaceAll(RegExp(r',\s*'), ' ');
    // Espaço após porcentagem
    parte = parte.replaceAll('%', '% ');
    // Espaço após valores numéricos
    parte = parte.replaceAllMapped(RegExp(r'(\d+)([a-zA-Záéíóúãõâêôç])'), (m) => '${m[1]} ${m[2]}');
    formatadas.add(parte);
  }
  // Junta tudo, separando passivas com linha extra
  String finalDesc = formatadas.join('. ');
  // Remove múltiplos espaços
  finalDesc = finalDesc.replaceAll(RegExp(r'\s+'), ' ');
  // Ajusta para que passivas fiquem em nova linha
  for (final p in passivas) {
    finalDesc = finalDesc.replaceAll('. $p:', '\n\n$p:');
  }
  // Garante que termina com ponto final
  finalDesc = finalDesc.trim();
  if (!finalDesc.endsWith('.')) finalDesc += '.';
  return finalDesc;
}

// Função para formatar categorias separando palavras compostas
String formatCategory(String cat) {
  return cat.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}');
}