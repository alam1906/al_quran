import 'dart:async';

import 'package:al_quran/providers/all_surat_provider.dart';
import 'package:flutter/material.dart';

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
  void dispose() {
    searcC;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => widget.title == null ? null : Navigator.pop(context),
        child: GestureDetector(
          onTap: () {
            widget.title == null
                ? Scaffold.of(context).openDrawer()
                : Navigator.pop(context);
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
                height: 35,
                child: TextField(
                  autofocus: true,
                  cursorHeight: 20,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xff682ebc),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xff682ebc),
                      ),
                    ),
                  ),
                  onChanged: (value) async {
                    Timer(
                      const Duration(milliseconds: 500),
                      () async {
                        await ref
                            .read(allSuratProvider.notifier)
                            .searchController(text: value);
                        setState(() {});
                      },
                    );
                  },
                ),
              )),
      actions: [
        GestureDetector(
          onTap: () async {
            if (isTap == false) {
              setState(() {
                isTap = !isTap;
              });
            } else {
              ref.read(allSuratProvider.notifier).refreshData();
              setState(() {
                isTap = !isTap;
              });
            }
          },
          child: Icon(
            widget.title != null ? null : Icons.search,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
