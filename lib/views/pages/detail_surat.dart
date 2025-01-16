import 'package:al_quran/models/ayat_model.dart';
import 'package:al_quran/models/detail_surat_model.dart';
import 'package:al_quran/providers/bookmark_provider.dart';
import 'package:al_quran/providers/detail_surat_provider.dart';
import 'package:al_quran/views/widgets/appbar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class DetailSurat extends ConsumerWidget {
  const DetailSurat({
    super.key,
    required this.nomor,
  });

  final int nomor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surat = ref.watch(detailSuratProvider(nomor)).valueOrNull;
    ColorScheme themeColor = Theme.of(context).colorScheme;
    if (surat == null) {
      return Scaffold(
        body: Center(
          child: LottieBuilder(
            width: 200,
            height: 100,
            filterQuality: FilterQuality.low,
            lottie: AssetLottie('assets/lotties/loading.json'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: Appbar(title: surat.namaLatin),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomScrollView(
          slivers: [
            CustomAppbar(surat: surat),
            _listAyat(surat, themeColor),
          ],
        ),
      ),
    );
  }

  _listAyat(DetailSuratModel surat, ColorScheme themeColor) {
    return SliverList.separated(
      itemCount: surat.ayat.length,
      itemBuilder: (context, index) {
        return Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeColor.secondaryContainer,
                // color: themeColor.secondaryContainer,
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
                      surat.ayat[index].nomorAyat.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Share(),
                  PlayAudio(
                    audioUrl: surat.ayat[index].audio['05'] ?? '',
                  ),
                  BookmarkItem(
                    data: surat.ayat[index],
                  ),
                ],
              ),
            ),
            Text(
              textAlign: TextAlign.end,
              surat.ayat[index].teksArab,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor.secondary,
              ),
            ),
            Text(
              surat.ayat[index].teksIndonesia,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: themeColor.secondary,
              ),
            ),
            SizedBox(
              height: index + 1 == surat.ayat.length ? 20 : 0,
            )
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
    );
  }
}

class Share extends StatelessWidget {
  const Share({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.share,
      color: Color(0xff682ebc),
    );
  }
}

class BookmarkItem extends ConsumerStatefulWidget {
  const BookmarkItem({
    super.key,
    required this.data,
  });
  final AyatModel data;

  @override
  ConsumerState<BookmarkItem> createState() => _BookmarkItemState();
}

class _BookmarkItemState extends ConsumerState<BookmarkItem> {
  @override
  Widget build(BuildContext context) {
    final teksIndonesia = widget.data.teksIndonesia.split('');
    final teksArab = widget.data.teksArab.split('');
    final resultIndonesia = teksIndonesia[0];
    final resultArab = teksArab[0];
    final key = "$resultIndonesia$resultArab";
    final data = ref.watch(bookmarkProvider.notifier).getByKey(key: key);
    bool isSelected = data?.isSelected ?? false;
    return GestureDetector(
      onTap: () async {
        if (isSelected == false) {
          await ref
              .read(bookmarkProvider.notifier)
              .addData(ayatModel: widget.data);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text("Berhasil menambahkan ke bookmark"),
            ),
          );
          setState(() {});
        } else {
          await ref.read(bookmarkProvider.notifier).deleteByKey(key: key);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text("Berhasil menghapus bookmark"),
            ),
          );
          setState(() {});
        }
      },
      child: Icon(
        isSelected ? Icons.bookmark : Icons.bookmark_outline,
        color: const Color(0xff682ebc),
      ),
    );
  }
}

class PlayAudio extends ConsumerStatefulWidget {
  const PlayAudio({
    super.key,
    required this.audioUrl,
  });
  final String audioUrl;

  @override
  ConsumerState<PlayAudio> createState() => _PlayAudioState();
}

class _PlayAudioState extends ConsumerState<PlayAudio> {
  bool isPlay = false;
  final audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    audioPlayer.onPlayerStateChanged.listen((value) {
      if (value == PlayerState.playing ||
          value == PlayerState.disposed ||
          value == PlayerState.stopped) {
        setState(() {
          isPlay = true;
        });
      } else if (value == PlayerState.paused) {
        setState(() {
          isPlay = false;
        });
      } else {
        setState(() {
          isPlay = false;
        });
      }
    });

    return GestureDetector(
      onTap: () async {
        if (isPlay == true) {
          await audioPlayer.pause();
        } else {
          await audioPlayer.play(UrlSource(widget.audioUrl));
        }
      },
      child: Icon(
        isPlay ? Icons.pause : Icons.play_arrow_outlined,
        color: const Color(0xff682ebc),
      ),
    );
  }
}

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.surat,
  });

  final DetailSuratModel? surat;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: const Color(0xff682ebc).withAlpha(180),
            gradient: const LinearGradient(colors: [
              Color(0xff682ebc),
              Colors.purple,
            ]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                surat!.namaLatin,
                style: const TextStyle(
                  letterSpacing: 5,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                surat!.arti,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const Divider(
                color: Colors.white,
                indent: 100,
                endIndent: 100,
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    surat!.tempatTurun.toUpperCase(),
                    style: const TextStyle(
                      letterSpacing: 3,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.circle,
                    size: 3,
                    color: Colors.blue,
                  ),
                  Text(
                    "${surat!.jumlahAyat.toString()} ayat".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
