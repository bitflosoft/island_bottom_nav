import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:island_bottom_nav/island_bottom_nav.dart';

void main() {
  group('IslandBottomNavBar example smoke tests', () {
    const items = [
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

    testWidgets('renders all nav labels and FAB', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: IslandAppShell(
            body: const Text('Body'),
            items: items,
            currentIndex: 0,
            onDestinationSelected: (_) {},
            onFabPressed: () {},
          ),
        ),
      );

      expect(find.text('Today'), findsOneWidget);
      expect(find.text('News+'), findsOneWidget);
      expect(find.text('Sports'), findsOneWidget);
      expect(find.text('Audio'), findsOneWidget);
      expect(find.byType(IslandFab), findsOneWidget);
    });

    testWidgets('switches displayed content on tab tap', (tester) async {
      var selectedIndex = 0;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) => MaterialApp(
            home: IslandAppShell(
              body: Text('Tab $selectedIndex'),
              items: items,
              currentIndex: selectedIndex,
              onDestinationSelected: (i) => setState(() => selectedIndex = i),
              onFabPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Tab 0'), findsOneWidget);

      await tester.tap(find.text('Sports'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 2);
      expect(find.text('Tab 2'), findsOneWidget);
    });

    testWidgets('FAB callback fires on tap', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: IslandAppShell(
            body: const SizedBox.shrink(),
            items: items,
            currentIndex: 0,
            onDestinationSelected: (_) {},
            onFabPressed: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.search_rounded));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });
  });
}
