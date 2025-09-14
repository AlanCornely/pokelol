import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ApiService {
  static const String baseUrl = 'https://ddragon.leagueoflegends.com';
  static const String version = '15.17.1';
  static const String language = 'pt_BR';

  static Future<List<LoLItem>> fetchItems() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cdn/$version/data/$language/item.json'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> itemsData = data['data'];
        
        List<LoLItem> items = [];
        itemsData.forEach((key, value) {
          items.add(LoLItem.fromJson(key, value));
        });
        
        // Filter out items that are not purchasable or are consumables/trinkets
        items = items.where((item) => 
          item.purchasable && 
          !item.tags.contains('Consumable') &&
          !item.tags.contains('Trinket') &&
          item.totalCost > 0
        ).toList();
        
        // Sort by total cost
        items.sort((a, b) => a.totalCost.compareTo(b.totalCost));
        
        return items;
      } else {
        throw Exception('Failed to load items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching items: $e');
    }
  }

  static Future<String> getLatestVersion() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/versions.json'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> versions = json.decode(response.body);
        return versions.first;
      } else {
        throw Exception('Failed to load versions');
      }
    } catch (e) {
      throw Exception('Error fetching versions: $e');
    }
  }
}

