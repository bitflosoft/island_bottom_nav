# Island App Shell

## Overview
`IslandAppShell` composes:
- your main page body
- a floating island bottom navigation bar
- a right-side island FAB

The shell is designed to mimic iOS island-like navigation treatment while staying fully configurable.

## Layout Behavior
- The control cluster is anchored to the bottom center.
- The navigation bar expands to fill available width inside the island cluster.
- The FAB is always rendered on the right side of the nav bar.
- `SafeArea` insets are respected so controls stay above gesture/navigation areas.

## Key Configuration
- `items`: navigation destinations (`IslandNavItem`)
- `currentIndex`: active destination index
- `onDestinationSelected`: nav tap callback
- `fab`: custom FAB widget (optional)
- `onFabPressed`: callback used by default `IslandFab`
- `fabSpacing`: spacing between bar and FAB
- `horizontalPadding`: left/right safe padding for floating cluster
- `bottomPadding`: extra bottom offset above system inset
- `maxIslandWidth`: max width of the nav+FAB row
- `navBarHeight`: height of the island nav bar

## Component-Level Customization
Use standalone widgets when you want tighter control:
- `IslandBottomNavBar`: customize color, border, elevation, label styles, and dimensions.
- `IslandFab`: customize icon/child, size, colors, border, tooltip, elevation.

## Minimal Example
```dart
import 'package:flutter/material.dart';
import 'package:island_bottom_nav/island_bottom_nav.dart';

class DemoShell extends StatefulWidget {
  const DemoShell({super.key});

  @override
  State<DemoShell> createState() => _DemoShellState();
}

class _DemoShellState extends State<DemoShell> {
  int index = 0;

  final items = const [
    IslandNavItem(icon: Icon(Icons.today_outlined), activeIcon: Icon(Icons.today), label: 'Today'),
    IslandNavItem(icon: Icon(Icons.newspaper_outlined), activeIcon: Icon(Icons.newspaper), label: 'News+'),
    IslandNavItem(icon: Icon(Icons.sports_football_outlined), activeIcon: Icon(Icons.sports_football), label: 'Sports'),
    IslandNavItem(icon: Icon(Icons.headset_outlined), activeIcon: Icon(Icons.headset), label: 'Audio'),
  ];

  @override
  Widget build(BuildContext context) {
    return IslandAppShell(
      body: Center(child: Text('Tab: ${items[index].label}')),
      items: items,
      currentIndex: index,
      onDestinationSelected: (value) => setState(() => index = value),
      onFabPressed: () {},
    );
  }
}
```
