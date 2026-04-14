import 'dart:ui';

import 'package:flutter/material.dart';

/// A circular floating action button styled as an island companion button.
class IslandFab extends StatelessWidget {
  /// Creates an island floating action button.
  const IslandFab({
    required this.onPressed,
    this.icon,
    this.child,
    this.size = 64,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.tooltip,
    this.elevation = 10,
    super.key,
  }) : assert(
         icon == null || child == null,
         'Provide only one of icon or child.',
       );

  /// Action callback.
  final VoidCallback onPressed;

  /// Optional icon shown in the center.
  final Widget? icon;

  /// Optional custom child.
  final Widget? child;

  /// Diameter of the button.
  final double size;

  /// Background fill color.
  final Color? backgroundColor;

  /// Foreground color for icon/child.
  final Color? foregroundColor;

  /// Border color.
  final Color? borderColor;

  /// Tooltip text.
  final String? tooltip;

  /// Material elevation.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.primaryContainer;
    final fg = foregroundColor ?? theme.colorScheme.onPrimaryContainer;

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      shape: const CircleBorder(),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bg.withValues(alpha: 0.9),
              border: Border.all(
                color:
                    borderColor ??
                    theme.colorScheme.outline.withValues(alpha: 0.45),
              ),
            ),
            child: SizedBox.square(
              dimension: size,
              child: IconTheme(
                data: IconThemeData(color: fg, size: 28),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onPressed,
                    child: Tooltip(
                      message: tooltip ?? 'Island action',
                      child: Center(
                        child:
                            child ?? icon ?? const Icon(Icons.search_rounded),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
