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
High-level shell with nav + right-side FAB. All visual and layout properties
are controlled via a single `theme: IslandNavThemeData(...)` parameter.

```dart
IslandAppShell(
  theme: IslandNavThemeData(
    backgroundColor: Colors.black.withValues(alpha: 0.85),
    borderColor: Colors.transparent,
    selectedColor: Colors.teal,
    navBarHeight: 64,
    fabSpacing: 10,
    horizontalPadding: 20,
    bottomPadding: 12,
    maxIslandWidth: 540,
  ),
  body: child,
  items: items,
  currentIndex: index,
  onDestinationSelected: (i) => setState(() => index = i),
)
```

When `theme` is omitted (or individual fields are `null`), values are derived
automatically from the ambient `ColorScheme` via `IslandNavThemeData.defaults`.

Other shell options:
- `fab`: provide your own custom island FAB widget.
- `onFabPressed`: callback used by the default `IslandFab`.
- `extendBody`: whether the body renders behind the floating bar (default: `true`).

### `IslandNavThemeData`
All appearance and layout settings in one place. Every field is nullable —
supply only the values you want to override.

| Property | Default | Description |
|---|---|---|
| `backgroundColor` | surface @ 84 % | Capsule fill |
| `borderColor` | outline @ 45 % | Use `Colors.transparent` to hide |
| `selectedColor` | `primary` | Active icon + label |
| `unselectedColor` | onSurface @ 55 % | Inactive icon + label |
| `labelStyle` / `selectedLabelStyle` | 12 sp | Label text styles |
| `elevation` | `8` | Capsule shadow |
| `borderRadius` | `36` | Capsule corner radius |
| `navBarHeight` | `64` | Bar height |
| `fabSpacing` | `12` | Gap between bar and FAB |
| `bottomPadding` | `12` | Space above system insets |
| `horizontalPadding` | `16` | Left/right padding of the control row |
| `maxIslandWidth` | `540` | Max width of the nav+FAB row |

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
