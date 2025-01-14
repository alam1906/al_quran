import 'package:al_quran/providers/bookmark_provider.dart';
import 'package:al_quran/views/pages/detail_surat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkPage extends ConsumerStatefulWidget {
  const BookmarkPage({super.key});

  @override
  ConsumerState<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends ConsumerState<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(bookmarkProvider).valueOrNull;
    if (data == null) {
      return const Center(
        child: Text("Tidak ada data"),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomScrollView(
        slivers: [
          SliverList.separated(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xff682ebc),
                          radius: 20,
                          child: Text(
                            data[index].nomorAyat.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Share(),
                        PlayAudio(
                          audioUrl: data[index].audio['05'],
                        ),
                        Delete(fn: () {
                          ref.read(bookmarkProvider.notifier).delete(id: index);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(milliseconds: 500),
                                  content:
                                      Text("Berhasil menghapus bookmark ")));
                          setState(() {});
                        })
                      ],
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.end,
                    data[index].teksArab,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data[index].teksIndonesia,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Divider(
                    thickness: 0.4,
                    color: Colors.grey,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class Delete extends ConsumerStatefulWidget {
  const Delete({
    super.key,
    required this.fn,
  });

  final VoidCallback fn;

  @override
  ConsumerState<Delete> createState() => _DeleteState();
}

class _DeleteState extends ConsumerState<Delete> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.fn,
      child: const Icon(
        Icons.delete_outline_sharp,
        color: Color(0xff682ebc),
      ),
    );
  }
}
