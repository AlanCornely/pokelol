import 'package:flutter/material.dart';
import 'screens/item_catalog_screen.dart';

void main() {
  runApp(const LoLItemCatalogApp());
}

class LoLItemCatalogApp extends StatelessWidget {
  const LoLItemCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League of Legends - Catálogo de Itens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF0F2027),
        scaffoldBackgroundColor: const Color(0xFF1E2328),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F2027),
          foregroundColor: Color(0xFFC9AA71),
          elevation: 0,
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFF3C3C41),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFF0E6D2)),
          bodyMedium: TextStyle(color: Color(0xFFA09B8C)),
          titleLarge: TextStyle(
            color: Color(0xFFC9AA71),
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Color(0xFFC9AA71),
            fontWeight: FontWeight.w600,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC9AA71),
          secondary: Color(0xFF0596AA),
          surface: Color(0xFF3C3C41),
          background: Color(0xFF1E2328),
          onPrimary: Color(0xFF0F2027),
          onSecondary: Color(0xFFF0E6D2),
          onSurface: Color(0xFFF0E6D2),
          onBackground: Color(0xFFF0E6D2),
        ),
      ),
      home: const ItemCatalogScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

