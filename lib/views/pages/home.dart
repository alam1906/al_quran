import 'package:al_quran/providers/all_surat_provider.dart';
import 'package:al_quran/providers/dark_model_provider.dart';
import 'package:al_quran/views/pages/bookmark.dart';
import 'package:al_quran/views/pages/detail_surat.dart';
import 'package:al_quran/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        drawer: const CustomDrawer(),
        bottomNavigationBar: _bottomNavbar(),
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

  StatefulBuilder _bottomNavbar() {
    return StatefulBuilder(builder: (context, s) {
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
    });
  }
}

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  ConsumerState<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(darkModelProvider).valueOrNull;
    if (data == null) {
      print(data);
      return Drawer();
    }

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 40,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Assalamualaikum",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "Nur Alam",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Switch(
                  inactiveThumbColor: Colors.white,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: data,
                  onChanged: (value) async {
                    await ref
                        .read(darkModelProvider.notifier)
                        .refreshData(value: value);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 170,
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
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              Image.asset('assets/images/readme.png'),
                              const Text(
                                "Last Read",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Al-Fatihah",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Ayat No.1",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1.1, 1),
                      child: Image.asset(
                        'assets/images/quran.png',
                        width: 220,
                        height: 110,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // CustomAppbar(),
          const ListSurat(),
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
    final ColorScheme themeColor = Theme.of(context).colorScheme;
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
            leading: Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/vector.svg',
                  width: 40,
                  height: 40,
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: Text(
                      surat.nomor.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: themeColor.secondary,
                      ),
                    ),
                  ),
                ),
              ],
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
                  style: TextStyle(
                    color: themeColor.secondary,
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
                  style: TextStyle(
                    color: themeColor.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: Text(
              surat.nama,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: themeColor.secondary,
              ),
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
