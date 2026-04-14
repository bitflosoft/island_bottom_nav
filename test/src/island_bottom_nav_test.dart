import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:island_bottom_nav/island_bottom_nav.dart';

void main() {
  group('IslandAppShell', () {
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

    testWidgets('renders destinations and body', (tester) async {
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

      expect(find.text('Body'), findsOneWidget);
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('News+'), findsOneWidget);
      expect(find.byType(IslandFab), findsOneWidget);
      expect(find.byType(IslandBottomNavBar), findsOneWidget);
    });

    testWidgets('calls destination callback on tap', (tester) async {
      var selectedIndex = -1;

      await tester.pumpWidget(
        MaterialApp(
          home: IslandAppShell(
            body: const SizedBox.shrink(),
            items: items,
            currentIndex: 0,
            onDestinationSelected: (index) => selectedIndex = index,
            onFabPressed: () {},
          ),
        ),
      );

      await tester.tap(find.text('Sports'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 2);
    });

    testWidgets('calls right-side fab callback', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: IslandAppShell(
            body: const SizedBox.shrink(),
            items: items,
            currentIndex: 0,
            onDestinationSelected: (_) {},
            onFabPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.search_rounded));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });
  });
}
