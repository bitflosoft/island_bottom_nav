import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:island_bottom_nav/src/island_bottom_nav_bar.dart';
import 'package:island_bottom_nav/src/island_fab.dart';
import 'package:island_bottom_nav/src/island_nav_item.dart';
import 'package:island_bottom_nav/src/island_nav_label_behavior.dart';
import 'package:island_bottom_nav/src/island_nav_theme_data.dart';

/// A configurable app shell that renders an island bottom bar
/// and right-side FAB.
///
/// Visual appearance is controlled by [IslandNavThemeData]. When [theme] is
/// omitted, or individual fields within it are `null`,
/// [IslandNavThemeData.defaults] fills in values derived from the ambient
/// [ColorScheme].
///
/// ```dart
/// IslandAppShell(
///   theme: IslandNavThemeData(
///     borderColor: Colors.transparent,
///     selectedIconColor: Theme.of(context).colorScheme.primary,
///     selectedBgColor:
///         Theme.of(context).colorScheme.primary.withValues(alpha: 0.13),
///   ),
///   body: child,
///   items: const [...],
///   currentIndex: _index,
///   onDestinationSelected: (i) => setState(() => _index = i),
/// )
/// ```
class IslandAppShell extends StatelessWidget {
  /// Creates the island app shell.
  const IslandAppShell({
    required this.body,
    required this.items,
    required this.currentIndex,
    required this.onDestinationSelected,
    this.theme,
    this.onFabPressed,
    this.fab,
    this.appBar,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBodyBehindAppBar = false,
    this.extendBody = true,
    this.restorationId,
    super.key,
  }) : assert(items.length >= 2, 'At least two island nav items are required.');

  /// Body content shown behind the floating island controls.
  final Widget body;

  /// Destinations shown in the island bar.
  final List<IslandNavItem> items;

  /// Currently selected destination index.
  final int currentIndex;

  /// Called when the user taps a destination.
  final ValueChanged<int> onDestinationSelected;

  /// Visual theme for the nav bar capsule.
  ///
  /// When `null`, all values are derived from the ambient [ColorScheme] via
  /// [IslandNavThemeData.defaults]. Supply a partial theme to override only
  /// specific properties â€” unset fields still fall back to the defaults.
  final IslandNavThemeData? theme;

  /// Optional callback for the default [IslandFab].
  final VoidCallback? onFabPressed;

  /// Optional custom FAB widget. If provided, [onFabPressed] is ignored.
  final Widget? fab;

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// A panel displayed to the side of the [body].
  final Widget? drawer;

  /// Called when the user opens or closes the drawer.
  final DrawerCallback? onDrawerChanged;

  /// A panel displayed to the side of the [body], on the opposite side from
  /// [drawer].
  final Widget? endDrawer;

  /// Called when the user opens or closes the end drawer.
  final DrawerCallback? onEndDrawerChanged;

  /// A persistent bottom sheet shown above the bottom navigation bar.
  final Widget? bottomSheet;

  /// The color of the [Material] widget that underlies the entire Scaffold.
  final Color? backgroundColor;

  /// Whether the body should size itself to avoid the window's bottom inset.
  final bool? resizeToAvoidBottomInset;

  /// Whether this scaffold is being displayed at the top of the screen.
  final bool primary;

  /// Determines the way that drag start behavior is handled.
  final DragStartBehavior drawerDragStartBehavior;

  /// Whether to extend body behind the app bar.
  final bool extendBodyBehindAppBar;

  /// Whether body should extend behind floating controls.
  final bool extendBody;

  /// Restoration ID to save and restore the state of the Scaffold.
  final String? restorationId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final defaults = IslandNavThemeData.defaults(colorScheme);
    final resolved = (theme ?? const IslandNavThemeData()).resolve(defaults);

    final resolvedFab =
        fab ??
        IslandFab(
          onPressed: onFabPressed ?? () {},
        );

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      onDrawerChanged: onDrawerChanged,
      endDrawer: endDrawer,
      onEndDrawerChanged: onEndDrawerChanged,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
      restorationId: restorationId,
      body: Stack(
        fit: StackFit.expand,
        children: [
          body,
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              minimum: EdgeInsets.only(
                left: resolved.horizontalPadding ?? 16,
                right: resolved.horizontalPadding ?? 16,
                bottom: resolved.bottomPadding ?? 12,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: resolved.maxIslandWidth ?? 540,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: IslandBottomNavBar(
                        items: items,
                        currentIndex: currentIndex,
                        onTap: onDestinationSelected,
                        height: resolved.navBarHeight ?? 64,
                        backgroundColor: resolved.backgroundColor,
                        borderColor: resolved.borderColor,
                        selectedIconColor: resolved.selectedIconColor,
                        unselectedIconColor: resolved.unselectedIconColor,
                        selectedBgColor: resolved.selectedBgColor,
                        unselectedBgColor: resolved.unselectedBgColor,
                        labelStyle: resolved.labelStyle,
                        selectedLabelStyle: resolved.selectedLabelStyle,
                        elevation: resolved.elevation ?? 8,
                        borderRadius: resolved.borderRadius ?? 36,
                        labelBehavior:
                            resolved.labelBehavior ??
                            IslandNavLabelBehavior.alwaysShow,
                      ),
                    ),
                    SizedBox(width: resolved.fabSpacing ?? 12),
                    resolvedFab,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
