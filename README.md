# Island Bottom Nav

Configurable iOS island-style bottom navigation for Flutter.

This package provides:
- `IslandBottomNavBar`: floating rounded bottom nav with icon + label destinations.
- `IslandFab`: island-style floating action button.
- `IslandAppShell`: composable shell that places nav and FAB together, with FAB on the right.

## Installation

```sh
dart pub add island_bottom_nav
```

## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:island_bottom_nav/island_bottom_nav.dart';

class HomeShell extends StatefulWidget {
	const HomeShell({super.key});

	@override
	State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
	int currentIndex = 0;

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

	@override
	Widget build(BuildContext context) {
		return IslandAppShell(
			body: Center(child: Text('Selected: ${items[currentIndex].label}')),
			items: items,
			currentIndex: currentIndex,
			onDestinationSelected: (index) => setState(() => currentIndex = index),
			onFabPressed: () {
				// Search, open modal, or route to another page.
			},
		);
	}
}
```

## Building Blocks

### `IslandAppShell`
High-level shell with nav + right-side FAB.

Key options:
- `fab`: provide your own custom island FAB widget.
- `fabSpacing`: spacing between nav and FAB.
- `maxIslandWidth`: max width for the floating control cluster.
- `horizontalPadding` and `bottomPadding`: tune placement above safe areas.
- `navBarHeight`: tune nav capsule size.

### `IslandBottomNavBar`
Standalone floating nav when you already have your own page shell.

Key options:
- `backgroundColor`, `borderColor`, `selectedColor`, `unselectedColor`
- `height`, `borderRadius`, `padding`, `elevation`
- `labelStyle`, `selectedLabelStyle`

### `IslandFab`
Standalone island action button.

Key options:
- `icon` or `child`
- `size`
- `backgroundColor`, `foregroundColor`, `borderColor`
- `tooltip`, `elevation`

## Docs

- `doc/island_app_shell.md` contains detailed behavior and configuration notes.

## Run The Example App

```sh
cd example
flutter pub get
flutter run
```

## Running Tests

```sh
flutter test
```
