import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/api_service.dart';
import '../widgets/item_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/filter_chips.dart';

class ItemCatalogScreen extends StatefulWidget {
  const ItemCatalogScreen({super.key});

  @override
  State<ItemCatalogScreen> createState() => _ItemCatalogScreenState();
}

class _ItemCatalogScreenState extends State<ItemCatalogScreen> {
  List<LoLItem> _allItems = [];
  List<LoLItem> _filteredItems = [];
  bool _isLoading = true;
  String _searchQuery = '';
  Set<String> _selectedTags = {};
  String _sortBy = 'name'; // 'name', 'cost', 'tags'

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final items = await ApiService.fetchItems();
      setState(() {
        _allItems = items;
        _filteredItems = items;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar itens: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _filterItems() {
    setState(() {
      _filteredItems = _allItems.where((item) {
        // Search filter
        bool matchesSearch = _searchQuery.isEmpty ||
            item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.plaintext.toLowerCase().contains(_searchQuery.toLowerCase());

        // Tag filter
        bool matchesTags = _selectedTags.isEmpty ||
            _selectedTags.any((tag) => item.tags.contains(tag));

        return matchesSearch && matchesTags;
      }).toList();

      // Sort items
      switch (_sortBy) {
        case 'name':
          _filteredItems.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'cost':
          _filteredItems.sort((a, b) => a.totalCost.compareTo(b.totalCost));
          break;
        case 'tags':
          _filteredItems.sort((a, b) => a.tags.join(',').compareTo(b.tags.join(',')));
          break;
      }
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _filterItems();
  }

  void _onTagToggled(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
    _filterItems();
  }

  void _onSortChanged(String sortBy) {
    setState(() {
      _sortBy = sortBy;
    });
    _filterItems();
  }

  Set<String> get _availableTags {
    Set<String> tags = {};
    for (var item in _allItems) {
      tags.addAll(item.tags);
    }
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'League of Legends - Catálogo de Itens',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: _onSortChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'name',
                child: Text('Ordenar por Nome'),
              ),
              const PopupMenuItem(
                value: 'cost',
                child: Text('Ordenar por Custo'),
              ),
              const PopupMenuItem(
                value: 'tags',
                child: Text('Ordenar por Categoria'),
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFFC9AA71),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Carregando itens...',
                    style: TextStyle(
                      color: Color(0xFFC9AA71),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomSearchBar(
                        onSearchChanged: _onSearchChanged,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Filtrar por categoria:',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
                          ),
                          const SizedBox(width: 12),
                          DropdownButton<String>(
                            value: _selectedTags.isEmpty ? null : _selectedTags.first,
                            hint: const Text('Selecione uma categoria'),
                            items: _availableTags.toList()..sort()
                              .map((tag) => DropdownMenuItem<String>(
                                    value: tag,
                                    child: Text(tag),
                                  ))
                              .toList(),
                            onChanged: (tag) {
                              setState(() {
                                _selectedTags.clear();
                                if (tag != null) _selectedTags.add(tag);
                              });
                              _filterItems();
                            },
                            isExpanded: false,
                          ),
                          if (_selectedTags.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.clear),
                              tooltip: 'Limpar filtro',
                              onPressed: () {
                                setState(() {
                                  _selectedTags.clear();
                                });
                                _filterItems();
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_filteredItems.length} itens encontrados',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Ordenado por: ${_sortBy == 'name' ? 'Nome' : _sortBy == 'cost' ? 'Custo' : 'Categoria'}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _filteredItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Nenhum item encontrado',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tente ajustar os filtros de busca',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 350,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) {
                            return ItemCard(item: _filteredItems[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

