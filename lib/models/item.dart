class LoLItem {
  final String id;
  final String name;
  final String description;
  final String plaintext;
  final String image;
  final int totalCost;
  final int sellPrice;
  final bool purchasable;
  final List<String> tags;
  final Map<String, dynamic> stats;
  final List<String> from;
  final List<String> into;

  LoLItem({
    required this.id,
    required this.name,
    required this.description,
    required this.plaintext,
    required this.image,
    required this.totalCost,
    required this.sellPrice,
    required this.purchasable,
    required this.tags,
    required this.stats,
    required this.from,
    required this.into,
  });

  factory LoLItem.fromJson(String id, Map<String, dynamic> json) {
    return LoLItem(
      id: id,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      plaintext: json['plaintext'] ?? '',
      image: json['image']?['full'] ?? '',
      totalCost: json['gold']?['total'] ?? 0,
      sellPrice: json['gold']?['sell'] ?? 0,
      purchasable: json['gold']?['purchasable'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
      stats: Map<String, dynamic>.from(json['stats'] ?? {}),
      from: List<String>.from(json['from'] ?? []),
      into: List<String>.from(json['into'] ?? []),
    );
  }

  String get imageUrl => 'https://ddragon.leagueoflegends.com/cdn/15.17.1/img/item/$image';

  String get cleanDescription {
    // Remove HTML tags from description
    return description.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  List<String> get mainStats {
    List<String> statsList = [];
    
    if (stats['FlatHPPoolMod'] != null && stats['FlatHPPoolMod'] > 0) {
      statsList.add('+${stats['FlatHPPoolMod']} Vida');
    }
    if (stats['FlatMPPoolMod'] != null && stats['FlatMPPoolMod'] > 0) {
      statsList.add('+${stats['FlatMPPoolMod']} Mana');
    }
    if (stats['FlatPhysicalDamageMod'] != null && stats['FlatPhysicalDamageMod'] > 0) {
      statsList.add('+${stats['FlatPhysicalDamageMod']} Dano de Ataque');
    }
    if (stats['FlatMagicDamageMod'] != null && stats['FlatMagicDamageMod'] > 0) {
      statsList.add('+${stats['FlatMagicDamageMod']} Poder de Habilidade');
    }
    if (stats['FlatArmorMod'] != null && stats['FlatArmorMod'] > 0) {
      statsList.add('+${stats['FlatArmorMod']} Armadura');
    }
    if (stats['FlatSpellBlockMod'] != null && stats['FlatSpellBlockMod'] > 0) {
      statsList.add('+${stats['FlatSpellBlockMod']} Resistência Mágica');
    }
    if (stats['PercentAttackSpeedMod'] != null && stats['PercentAttackSpeedMod'] > 0) {
      statsList.add('+${(stats['PercentAttackSpeedMod'] * 100).toStringAsFixed(0)}% Velocidade de Ataque');
    }
    if (stats['FlatCritChanceMod'] != null && stats['FlatCritChanceMod'] > 0) {
      statsList.add('+${(stats['FlatCritChanceMod'] * 100).toStringAsFixed(0)}% Chance de Crítico');
    }
    if (stats['FlatMovementSpeedMod'] != null && stats['FlatMovementSpeedMod'] > 0) {
      statsList.add('+${stats['FlatMovementSpeedMod']} Velocidade de Movimento');
    }
    
    return statsList;
  }
}

