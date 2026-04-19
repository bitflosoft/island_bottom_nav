import 'package:flutter/material.dart';
import 'package:island_bottom_nav/island_bottom_nav.dart';

void main() {
  runApp(const _IslandExampleApp());
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.index, required this.section});

  final int index;
  final String section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withValues(alpha: 0.72),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primaryContainer,
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$section article item #$index',
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoContent extends StatelessWidget {
  const _DemoContent({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF8FCFF),
            Color(0xFFEFFAF9),
            Color(0xFFEAEFFE),
          ],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            backgroundColor: Colors.transparent,
            title: Text('Island Navigation'),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
            sliver: SliverList.list(
              children: [
                _HeadlineCard(title: title),
                const SizedBox(height: 16),
                for (var i = 0; i < 7; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ArticleCard(index: i + 1, section: title),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeadlineCard extends StatelessWidget {
  const _HeadlineCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white.withValues(alpha: 0.85),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Now browsing: $title',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Example app shell using IslandAppShell, IslandBottomNavBar, '
            'and a right-aligned IslandFab.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _IslandDemoPage extends StatefulWidget {
  const _IslandDemoPage();

  @override
  State<_IslandDemoPage> createState() => _IslandDemoPageState();
}

class _IslandDemoPageState extends State<_IslandDemoPage> {
  static const items = [
    IslandNavItem(
      icon: Icon(Icons.today_outlined),
      activeIcon: Icon(Icons.today),
      label: 'Today',
    ),
    IslandNavItem(
      icon: Icon(Icons.newspaper_outlined),
      activeIcon: Icon(Icons.newspaper),
      label: 'News+',
    ),
    IslandNavItem(
      icon: Icon(Icons.sports_football_outlined),
      activeIcon: Icon(Icons.sports_football),
      label: 'Sports',
    ),
    IslandNavItem(
      icon: Icon(Icons.headset_outlined),
      activeIcon: Icon(Icons.headset),
      label: 'Audio',
    ),
  ];

  int currentIndex = 1;

  String get currentTitle => items[currentIndex].label;

  @override
  Widget build(BuildContext context) {
    return IslandAppShell(
      body: _DemoContent(
        title: currentTitle,
      ),
      items: items,
      currentIndex: currentIndex,
      onDestinationSelected: (index) {
        setState(() => currentIndex = index);
      },
      fab: IslandFab(
        tooltip: 'Search',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Island FAB tapped')),
          );
        },
        icon: const Icon(Icons.search_rounded),
      ),
      theme: const IslandNavThemeData(
        maxIslandWidth: 720,
        navBarHeight: 76,
        fabSpacing: 10,
        horizontalPadding: 20,
        bottomPadding: 10,
      ),
    );
  }
}

class _IslandExampleApp extends StatelessWidget {
  const _IslandExampleApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Island Bottom Nav Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C1B6),
        ),
        useMaterial3: true,
      ),
      home: const _IslandDemoPage(),
    );
  }
}
