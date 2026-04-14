import 'package:flutter/widgets.dart';
import 'package:island_bottom_nav/island_bottom_nav.dart'
    show IslandBottomNavBar;
import 'package:island_bottom_nav/src/island_bottom_nav.dart'
    show IslandBottomNavBar;
import 'package:island_bottom_nav/src/island_bottom_nav_bar.dart'
    show IslandBottomNavBar;

/// Describes a destination rendered inside [IslandBottomNavBar].
class IslandNavItem {
  /// Creates an island navigation destination.
  const IslandNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.tooltip,
    this.semanticLabel,
  });

  /// Icon displayed when the destination is not selected.
  final Widget icon;

  /// Optional icon displayed when the destination is selected.
  final Widget? activeIcon;

  /// Text label shown under the icon.
  final String label;

  /// Optional tooltip shown on long press.
  final String? tooltip;

  /// Optional accessibility label for the destination button.
  final String? semanticLabel;
}
