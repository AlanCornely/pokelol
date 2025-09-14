import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final List<String> availableTags;
  final Set<String> selectedTags;
  final Function(String) onTagToggled;

  const FilterChips({
    super.key,
    required this.availableTags,
    required this.selectedTags,
    required this.onTagToggled,
  });

  @override
  Widget build(BuildContext context) {
    if (availableTags.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filtrar por categoria:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: availableTags.length,
            itemBuilder: (context, index) {
              final tag = availableTags[index];
              final isSelected = selectedTags.contains(tag);
              
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(
                    tag,
                    style: TextStyle(
                      color: isSelected 
                          ? const Color(0xFF0F2027)
                          : const Color(0xFFC9AA71),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) => onTagToggled(tag),
                  backgroundColor: const Color(0xFF3C3C41),
                  selectedColor: const Color(0xFFC9AA71),
                  checkmarkColor: const Color(0xFF0F2027),
                  side: BorderSide(
                    color: isSelected 
                        ? const Color(0xFFC9AA71)
                        : const Color(0xFF5BC0DE),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
// Widget removido. O filtro de categorias agora é feito por dropdown no item_catalog_screen.dart

