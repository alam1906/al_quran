import 'package:al_quran/providers/all_surat_provider.dart';
import 'package:al_quran/views/pages/bookmark.dart';
import 'package:al_quran/views/pages/detail_surat.dart';
import 'package:al_quran/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: StatefulBuilder(builder: (context, s) {
          return BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              switch (value) {
                case 0:
                  s(() {
                    currentIndex = 0;
                  });
                  pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                  break;
                case 1:
                  s(() {
                    currentIndex = 1;
                  });
                  pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                  break;
                default:
              }
            },
            backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                label: "quran",
                icon: Icon(
                  Icons.quora_outlined,
                ),
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(
                  Icons.bookmark_outline,
                ),
                label: "Bookmark",
                icon: Icon(
                  Icons.bookmark_outline,
                ),
              ),
            ],
          );
        }),
        appBar: const Appbar(title: null),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            HomePage(),
            BookmarkPage(),
          ],
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomScrollView(
        slivers: [
          // CustomAppbar(),
          ListSurat(),
        ],
      ),
    );
  }
}

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 100,
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
            child: const Center(
              child: Text(
                "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            )),
      ),
    );
  }
}

class ListSurat extends ConsumerWidget {
  const ListSurat({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(allSuratProvider).valueOrNull;
    if (data == null) {
      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SliverList.separated(
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          indent: 5,
          endIndent: 5,
          thickness: 0.5,
        );
      },
      itemCount: data.length,
      itemBuilder: (context, index) {
        final surat = data[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailSurat(
                nomor: surat.nomor,
              ),
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(2),
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xff682ebc),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Center(
                  child: Text(
                    surat.nomor.toString(),
                    style: const TextStyle(
                      color: Color(0xff682ebc),
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              surat.namaLatin,
              style: const TextStyle(
                color: Color(0xff682ebc),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              spacing: 10,
              children: [
                Text(
                  surat.tempatTurun,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.circle,
                  size: 5,
                  color: Color(0xff682ebc),
                ),
                Text(
                  "${surat.jumlahAyat.toString()} ayat",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: Text(
              surat.nama,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
          ),
        );
      },
    );
  }
}

class Banner extends StatefulWidget {
  const Banner({
    super.key,
  });

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Text(
          "AL-QURAN",
          style: TextStyle(
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}

class SpaceVertical extends StatelessWidget {
  const SpaceVertical({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
