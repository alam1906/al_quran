import 'package:al_quran/providers/all_surat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Appbar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const Appbar({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  ConsumerState<Appbar> createState() => _AppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppbarState extends ConsumerState<Appbar> {
  TextEditingController searcC = TextEditingController();
  bool isTap = false;
  bool isDelete = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => widget.title == null ? null : Navigator.pop(context),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isTap = !isTap;
            });
          },
          child: Icon(
            widget.title == null ? Icons.menu : Icons.arrow_back,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      title: isTap == false
          ? Text(
              widget.title ?? "Quran App",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff682ebc),
              ),
            )
          : GestureDetector(
              onTap: () {
                setState(() {
                  isTap = !isTap;
                });
              },
              child: SizedBox(
                child: Focus(
                  onKeyEvent: (node, event) {
                    if (event.logicalKey == LogicalKeyboardKey.backspace) {}
                    return KeyEventResult.ignored;
                  },
                  child: TextField(
                    onChanged: (value) async {
                      await ref
                          .read(allSuratProvider.notifier)
                          .searchController(text: value);
                      setState(() {});
                    },
                  ),
                ),
              )),
      actions: [
        GestureDetector(
          onTap: () {
            setState(() {
              isTap = !isTap;
            });
          },
          child: const Icon(
            Icons.search,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
