import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => title == null ? null : Navigator.pop(context),
        child: Icon(
          title == null ? Icons.menu : Icons.arrow_back,
          color: Colors.grey.shade700,
        ),
      ),
      title: Text(
        title ?? "Quran App",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xff682ebc),
        ),
      ),
      actions: const [
        Icon(
          Icons.search,
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
