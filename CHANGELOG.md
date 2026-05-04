# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.3.0

### Added
- Granular color control in `IslandNavThemeData`:
  - `selectedIconColor` — color for selected destination icons.
  - `unselectedIconColor` — color for unselected destination icons.
  - `selectedBgColor` — background color for the selected item container.
  - `unselectedBgColor` — background color for unselected item containers.
- Icon and background colors are now independent, enabling more flexible theming.

### Changed ⚠ Breaking
- `IslandBottomNavBar` constructor: replaced `selectedColor` and `unselectedColor`
  parameters with `selectedIconColor`, `unselectedIconColor`, `selectedBgColor`,
  and `unselectedBgColor` for granular control.
- `IslandNavThemeData`: replaced `selectedColor` and `unselectedColor` fields
  with the new four-property system.  
  **Migration:** use separate icon and background colors instead of a single color.

## 0.2.1

### Added
- `IslandNavLabelBehavior` enum — controls when destination labels are rendered:
  - `alwaysShow` (default) — labels always visible.
  - `alwaysHide` — icons only, labels never rendered.
  - `onlyShowSelected` — label shown only for the active destination.
- `IslandNavThemeData.labelBehavior` field — set once in the theme to apply
  the chosen behaviour across all destinations.
- `IslandBottomNavBar.labelBehavior` parameter — for standalone bar usage
  without `IslandAppShell`.

## 0.2.0

### Added
- `IslandNavThemeData`: a dedicated theme class that centralises all visual and
  layout configuration for the island shell. Supports `copyWith`, `resolve`,
  `lerp`, `==`/`hashCode`, and `debugFillProperties`.
- `IslandNavThemeData.defaults(colorScheme)`: derives a fully-resolved theme
  from the ambient `ColorScheme`, used as the automatic fallback when `theme`
  is omitted or fields are null.
- `IslandAppShell.theme` parameter — supply an `IslandNavThemeData` to override
  any subset of properties; unset fields fall back to `defaults` automatically.

### Changed ⚠ Breaking
- Removed individual `IslandAppShell` constructor parameters:
  `navBarHeight`, `fabSpacing`, `bottomPadding`, `horizontalPadding`,
  `maxIslandWidth`, `navBackgroundColor`, `navBorderColor`, `navSelectedColor`,
  `navUnselectedColor`, `navLabelStyle`, `navSelectedLabelStyle`,
  `navElevation`, `navBorderRadius`.  
  **Migration:** pass these values via `theme: IslandNavThemeData(...)` instead.

## 0.1.0

### Added
- `IslandNavItem`: configurable navigation destination model (icon, activeIcon, label, tooltip, semanticLabel).
- `IslandBottomNavBar`: floating rounded capsule navigation bar with backdrop blur, animated active pill, and `spaceEvenly` destination layout.
- `IslandFab`: circular island-style floating action button with backdrop blur, configurable size, colors, icon/child, and tooltip.
- `IslandAppShell`: composable app shell that positions the island nav bar and a right-aligned `IslandFab` above safe area insets.
- Full example app demonstrating all components on Windows, Chrome, and mobile.
