import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:island_bottom_nav/src/island_nav_item.dart';
import 'package:island_bottom_nav/src/island_nav_label_behavior.dart';

/// A floating, rounded navigation bar inspired by iOS island-style navigation.
class IslandBottomNavBar extends StatelessWidget {
  /// Creates a floating bottom navigation bar.
  const IslandBottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.height = 72,
    this.borderRadius = 36,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.backgroundColor,
    this.borderColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.selectedBgColor,
    this.unselectedBgColor,
    this.labelStyle,
    this.selectedLabelStyle,
    this.elevation = 8,
    this.labelBehavior = IslandNavLabelBehavior.alwaysShow,
    super.key,
  }) : assert(items.length >= 2, 'At least two island nav items are required.'),
       assert(currentIndex >= 0, 'currentIndex must be >= 0.'),
       assert(
         currentIndex < items.length,
         'currentIndex must be less than items.length.',
       );

  /// Destinations shown in the bar.
  final List<IslandNavItem> items;

  /// Currently active destination index.
  final int currentIndex;

  /// Called when a destination is tapped.
  final ValueChanged<int> onTap;

  /// Total height of the capsule.
  final double height;

  /// Capsule corner radius.
  final double borderRadius;

  /// Internal padding around destination buttons.
  final EdgeInsetsGeometry padding;

  /// Background color of the glass capsule.
  final Color? backgroundColor;

  /// Border color of the capsule.
  final Color? borderColor;

  /// Color used by selected icon.
  final Color? selectedIconColor;

  /// Color used by unselected icon.
  final Color? unselectedIconColor;

  /// Background color for selected item.
  final Color? selectedBgColor;

  /// Background color for unselected item.
  final Color? unselectedBgColor;

  /// Base text style for labels.
  final TextStyle? labelStyle;

  /// Text style for selected label.
  final TextStyle? selectedLabelStyle;

  /// Shadow elevation.
  final double elevation;

  /// Controls when labels are shown beneath destination icons.
  ///
  /// Defaults to [IslandNavLabelBehavior.alwaysShow].
  final IslandNavLabelBehavior labelBehavior;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedIcon = selectedIconColor ?? theme.colorScheme.onSurface;
    final unselectedIcon =
        unselectedIconColor ??
        theme.colorScheme.onSurface.withValues(alpha: 0.65);
    final selectedBg =
        selectedBgColor ?? theme.colorScheme.primary.withValues(alpha: 0.13);
    final unselectedBg = unselectedBgColor ?? Colors.transparent;
    final resolvedLabelStyle =
        labelStyle ??
        theme.textTheme.labelMedium ??
        const TextStyle(fontSize: 12);

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color:
                  backgroundColor ??
                  theme.colorScheme.surface.withValues(alpha: 0.84),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color:
                    borderColor ??
                    theme.colorScheme.outline.withValues(alpha: 0.45),
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: height),
              child: Padding(
                padding: padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(items.length, (index) {
                    final item = items[index];
                    final isSelected = index == currentIndex;
                    return _IslandDestination(
                      item: item,
                      selected: isSelected,
                      selectedIconColor: selectedIcon,
                      unselectedIconColor: unselectedIcon,
                      selectedBgColor: selectedBg,
                      unselectedBgColor: unselectedBg,
                      labelStyle: resolvedLabelStyle,
                      selectedLabelStyle: selectedLabelStyle,
                      labelBehavior: labelBehavior,
                      onTap: () => onTap(index),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IslandDestination extends StatelessWidget {
  const _IslandDestination({
    required this.item,
    required this.selected,
    required this.selectedIconColor,
    required this.unselectedIconColor,
    required this.selectedBgColor,
    required this.unselectedBgColor,
    required this.labelStyle,
    required this.selectedLabelStyle,
    required this.labelBehavior,
    required this.onTap,
  });

  final IslandNavItem item;
  final bool selected;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Color selectedBgColor;
  final Color unselectedBgColor;
  final TextStyle labelStyle;
  final TextStyle? selectedLabelStyle;
  final IslandNavLabelBehavior labelBehavior;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = selected ? selectedIconColor : unselectedIconColor;
    final bgColor = selected ? selectedBgColor : unselectedBgColor;
    final showLabel = switch (labelBehavior) {
      IslandNavLabelBehavior.alwaysShow => true,
      IslandNavLabelBehavior.alwaysHide => false,
      IslandNavLabelBehavior.onlyShowSelected => selected,
    };
    final label = Text(
      item.label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    return Tooltip(
      message: item.tooltip ?? item.label,
      child: Semantics(
        button: true,
        label: item.semanticLabel ?? item.label,
        child: InkResponse(
          onTap: onTap,
          radius: 32,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconTheme(
                  data: IconThemeData(
                    color: iconColor,
                    size: 24,
                    weight: selected ? 700 : 400,
                  ),
                  child: selected && item.activeIcon != null
                      ? item.activeIcon!
                      : item.icon,
                ),
                const SizedBox(height: 3),
                if (showLabel)
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 220),
                    style:
                        (selected ? selectedLabelStyle : null) ??
                        labelStyle.copyWith(
                          color: iconColor,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                    child: label,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
