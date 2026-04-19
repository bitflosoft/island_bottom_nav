# Island App Shell

## Overview
`IslandAppShell` composes:
- your main page body
- a floating island bottom navigation bar
- a right-side island FAB

The shell is designed to mimic iOS island-like navigation treatment while staying
fully configurable. All visual and layout properties are controlled through a
single `IslandNavThemeData` object.

## Layout Behavior
- The control cluster is anchored to the bottom center.
- The navigation bar expands to fill available width inside the island cluster.
- The FAB is always rendered on the right side of the nav bar.
- `SafeArea` insets are respected so controls stay above gesture/navigation areas.
- When `extendBody` is `true` (the default) the body renders behind the floating
  controls, allowing content to scroll beneath the bar.

## Constructor Parameters

| Parameter | Type | Description |
|---|---|---|
| `body` | `Widget` | Page content rendered behind the floating controls |
| `items` | `List<IslandNavItem>` | Navigation destinations (min 2) |
| `currentIndex` | `int` | Active destination index |
| `onDestinationSelected` | `ValueChanged<int>` | Called when user taps a destination |
| `theme` | `IslandNavThemeData?` | Visual + layout theme; falls back to `IslandNavThemeData.defaults` |
| `fab` | `Widget?` | Custom FAB widget; overrides the default `IslandFab` |
| `onFabPressed` | `VoidCallback?` | Callback used by the default `IslandFab` |
| `extendBody` | `bool` | Whether body extends behind the floating bar (default: `true`) |

## IslandNavThemeData

All visual and layout customisation lives in `IslandNavThemeData`. Every field is
nullable — omitted fields fall back to values derived from the ambient
`ColorScheme` via `IslandNavThemeData.defaults`.

### Visual properties

| Property | Default | Description |
|---|---|---|
| `backgroundColor` | `colorScheme.surface` at 84 % opacity | Capsule fill color |
| `borderColor` | `colorScheme.outline` at 45 % opacity | Capsule border; use `Colors.transparent` to hide |
| `selectedColor` | `colorScheme.primary` | Active icon + label color |
| `unselectedColor` | `colorScheme.onSurface` at 55 % opacity | Inactive icon + label color |
| `labelStyle` | 12 sp, w500, unselected color | Base text style for all labels |
| `selectedLabelStyle` | 12 sp, w700, selected color | Text style for the active label |
| `elevation` | `8` | Shadow elevation of the capsule |
| `borderRadius` | `36` | Corner radius of the capsule |
| `navBarHeight` | `64` | Height of the nav bar capsule |

### Layout properties

| Property | Default | Description |
|---|---|---|
| `fabSpacing` | `12` | Gap between the nav bar and the FAB |
| `bottomPadding` | `12` | Extra bottom spacing above system insets |
| `horizontalPadding` | `16` | Left/right padding for the floating control row |
| `maxIslandWidth` | `540` | Maximum width of the nav + FAB row |

### Helpers

- `IslandNavThemeData.defaults(colorScheme)` — factory that produces a fully
  resolved theme from the provided `ColorScheme`.
- `copyWith({...})` — returns a new instance with selected fields replaced.
- `resolve(defaults)` — fills any `null` fields from a defaults instance.
- `lerp(a, b, t)` — linear interpolation for animation.

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

## Themed Example
```dart
IslandAppShell(
  theme: IslandNavThemeData(
    backgroundColor: Colors.black.withValues(alpha: 0.85),
    borderColor: Colors.transparent,
    selectedColor: Colors.teal,
    navBarHeight: 60,
    bottomPadding: 16,
    horizontalPadding: 20,
    maxIslandWidth: 480,
    fabSpacing: 10,
  ),
  body: child,
  items: items,
  currentIndex: index,
  onDestinationSelected: (i) => setState(() => index = i),
  fab: IslandFab(
    onPressed: _onAdd,
    icon: const Icon(Icons.add),
  ),
)
```
