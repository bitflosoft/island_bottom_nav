import 'package:flutter/material.dart';
import 'package:island_bottom_nav/src/island_bottom_nav_bar.dart';
import 'package:island_bottom_nav/src/island_fab.dart';
import 'package:island_bottom_nav/src/island_nav_item.dart';

/// A configurable app shell that renders an island bottom bar
/// and right-side FAB
class IslandAppShell extends StatelessWidget {
  /// Creates the island app shell.
  const IslandAppShell({
    required this.body,
    required this.items,
    required this.currentIndex,
    required this.onDestinationSelected,
    this.onFabPressed,
    this.fab,
    this.fabSpacing = 12,
    this.bottomPadding = 12,
    this.horizontalPadding = 16,
    this.maxIslandWidth = 540,
    this.navBarHeight = 72,
    this.extendBody = true,
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

  /// Optional callback for the default [IslandFab].
  final VoidCallback? onFabPressed;

  /// Optional custom FAB widget. If provided, [onFabPressed] is ignored.
  final Widget? fab;

  /// Gap between nav bar and FAB.
  final double fabSpacing;

  /// Additional bottom spacing above system insets.
  final double bottomPadding;

  /// Horizontal page padding for floating controls.
  final double horizontalPadding;

  /// Max width used by the floating control row.
  final double maxIslandWidth;

  /// Height of the island navigation bar.
  final double navBarHeight;

  /// Whether body should extend behind floating controls.
  final bool extendBody;

  @override
  Widget build(BuildContext context) {
    final resolvedFab =
        fab ??
        IslandFab(
          onPressed: onFabPressed ?? () {},
        );

    return Scaffold(
      extendBody: extendBody,
      body: Stack(
        fit: StackFit.expand,
        children: [
          body,
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              minimum: EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: bottomPadding,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxIslandWidth),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: IslandBottomNavBar(
                        items: items,
                        currentIndex: currentIndex,
                        onTap: onDestinationSelected,
                        height: navBarHeight,
                      ),
                    ),
                    SizedBox(width: fabSpacing),
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
