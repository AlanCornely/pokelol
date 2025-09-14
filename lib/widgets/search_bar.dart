import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;

  const CustomSearchBar({super.key, required this.onSearchChanged});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3C3C41),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF5BC0DE),
          width: 1,
        ),
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onSearchChanged,
        style: const TextStyle(
          color: Color(0xFFF0E6D2),
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Buscar itens...',
          hintStyle: const TextStyle(
            color: Color(0xFFA09B8C),
            fontSize: 16,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFC9AA71),
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Color(0xFFA09B8C),
                  ),
                  onPressed: () {
                    _controller.clear();
                    widget.onSearchChanged('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

