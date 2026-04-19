import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines the visual theme for the island nav bar and its host shell.
///
/// All properties are nullable — when a value is `null` the widget falls back
/// to a value derived from the ambient [ColorScheme] at build time via
/// [IslandNavThemeData.defaults].
///
/// See also:
/// * `IslandAppShell`, which consumes this theme.
/// * `IslandBottomNavBar`, which renders the capsule.
///
/// **Typical usage**
/// ```dart
/// IslandAppShell(
///   theme: IslandNavThemeData(
///     backgroundColor: Colors.black.withOpacity(0.8),
///     borderColor: Colors.transparent,
///     selectedColor: Colors.teal,
///   ),
///   ...
/// )
/// ```
@immutable
class IslandNavThemeData with Diagnosticable {
  /// Creates an [IslandNavThemeData].
  ///
  /// All fields are optional — pass only the values you want to override.
  /// Unset fields resolve to [IslandNavThemeData.defaults] at render time.
  const IslandNavThemeData({
    this.backgroundColor,
    this.borderColor,
    this.selectedColor,
    this.unselectedColor,
    this.labelStyle,
    this.selectedLabelStyle,
    this.elevation,
    this.borderRadius,
    this.navBarHeight,
    this.fabSpacing,
    this.bottomPadding,
    this.horizontalPadding,
    this.maxIslandWidth,
  });

  /// Derives a fully-specified theme from [colorScheme].
  ///
  /// Used as the fallback when the shell's `theme` property is `null`, or to
  /// fill individual `null` fields when calling [resolve].
  factory IslandNavThemeData.defaults(ColorScheme colorScheme) {
    return IslandNavThemeData(
      backgroundColor: colorScheme.surface.withValues(alpha: 0.84),
      borderColor: colorScheme.outline.withValues(alpha: 0.45),
      selectedColor: colorScheme.primary,
      unselectedColor: colorScheme.onSurface.withValues(alpha: 0.55),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface.withValues(alpha: 0.55),
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: colorScheme.primary,
      ),
      elevation: 8,
      borderRadius: 36,
      navBarHeight: 64,
      fabSpacing: 12,
      bottomPadding: 12,
      horizontalPadding: 16,
      maxIslandWidth: 540,
    );
  }

  // ── Fields ─────────────────────────────────────────────────────────────────

  /// Background color of the glass capsule.
  final Color? backgroundColor;

  /// Border color of the capsule.
  ///
  /// Set to [Colors.transparent] to hide the border entirely.
  final Color? borderColor;

  /// Color used by the selected icon and label.
  final Color? selectedColor;

  /// Color used by unselected icons and labels.
  final Color? unselectedColor;

  /// Base text style applied to all labels.
  final TextStyle? labelStyle;

  /// Text style applied to the currently selected label.
  ///
  /// Falls back to [labelStyle] when null.
  final TextStyle? selectedLabelStyle;

  /// Shadow elevation of the capsule. Defaults to `8`.
  final double? elevation;

  /// Corner radius of the capsule. Defaults to `36`.
  final double? borderRadius;

  /// Height of the navigation bar capsule. Defaults to `64`.
  final double? navBarHeight;

  /// Gap between the nav bar and the FAB. Defaults to `12`.
  final double? fabSpacing;

  /// Additional bottom spacing above system insets. Defaults to `12`.
  final double? bottomPadding;

  /// Horizontal page padding for the floating control row. Defaults to `16`.
  final double? horizontalPadding;

  /// Maximum width of the floating control row. Defaults to `540`.
  final double? maxIslandWidth;

  // ── Helpers ────────────────────────────────────────────────────────────────

  @override
  int get hashCode => Object.hash(
    backgroundColor,
    borderColor,
    selectedColor,
    unselectedColor,
    labelStyle,
    selectedLabelStyle,
    elevation,
    borderRadius,
    navBarHeight,
    fabSpacing,
    bottomPadding,
    horizontalPadding,
    maxIslandWidth,
  );

  // ── Object ─────────────────────────────────────────────────────────────────

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IslandNavThemeData &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.selectedColor == selectedColor &&
        other.unselectedColor == unselectedColor &&
        other.labelStyle == labelStyle &&
        other.selectedLabelStyle == selectedLabelStyle &&
        other.elevation == elevation &&
        other.borderRadius == borderRadius &&
        other.navBarHeight == navBarHeight &&
        other.fabSpacing == fabSpacing &&
        other.bottomPadding == bottomPadding &&
        other.horizontalPadding == horizontalPadding &&
        other.maxIslandWidth == maxIslandWidth;
  }

  /// Returns a copy of this theme with the given fields replaced.
  IslandNavThemeData copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? selectedColor,
    Color? unselectedColor,
    TextStyle? labelStyle,
    TextStyle? selectedLabelStyle,
    double? elevation,
    double? borderRadius,
    double? navBarHeight,
    double? fabSpacing,
    double? bottomPadding,
    double? horizontalPadding,
    double? maxIslandWidth,
  }) {
    return IslandNavThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      labelStyle: labelStyle ?? this.labelStyle,
      selectedLabelStyle: selectedLabelStyle ?? this.selectedLabelStyle,
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      navBarHeight: navBarHeight ?? this.navBarHeight,
      fabSpacing: fabSpacing ?? this.fabSpacing,
      bottomPadding: bottomPadding ?? this.bottomPadding,
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      maxIslandWidth: maxIslandWidth ?? this.maxIslandWidth,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('borderColor', borderColor))
      ..add(ColorProperty('selectedColor', selectedColor))
      ..add(ColorProperty('unselectedColor', unselectedColor))
      ..add(DiagnosticsProperty<TextStyle>('labelStyle', labelStyle))
      ..add(
        DiagnosticsProperty<TextStyle>(
          'selectedLabelStyle',
          selectedLabelStyle,
        ),
      )
      ..add(DoubleProperty('elevation', elevation))
      ..add(DoubleProperty('borderRadius', borderRadius))
      ..add(DoubleProperty('navBarHeight', navBarHeight))
      ..add(DoubleProperty('fabSpacing', fabSpacing))
      ..add(DoubleProperty('bottomPadding', bottomPadding))
      ..add(DoubleProperty('horizontalPadding', horizontalPadding))
      ..add(DoubleProperty('maxIslandWidth', maxIslandWidth));
  }

  /// Returns a new theme where every `null` field in `this` is filled with
  /// the corresponding value from [defaults].
  ///
  /// This lets callers supply only the properties they care about while
  /// ensuring every field has a concrete value for rendering.
  IslandNavThemeData resolve(IslandNavThemeData defaults) {
    return IslandNavThemeData(
      backgroundColor: backgroundColor ?? defaults.backgroundColor,
      borderColor: borderColor ?? defaults.borderColor,
      selectedColor: selectedColor ?? defaults.selectedColor,
      unselectedColor: unselectedColor ?? defaults.unselectedColor,
      labelStyle: labelStyle ?? defaults.labelStyle,
      selectedLabelStyle: selectedLabelStyle ?? defaults.selectedLabelStyle,
      elevation: elevation ?? defaults.elevation,
      borderRadius: borderRadius ?? defaults.borderRadius,
      navBarHeight: navBarHeight ?? defaults.navBarHeight,
      fabSpacing: fabSpacing ?? defaults.fabSpacing,
      bottomPadding: bottomPadding ?? defaults.bottomPadding,
      horizontalPadding: horizontalPadding ?? defaults.horizontalPadding,
      maxIslandWidth: maxIslandWidth ?? defaults.maxIslandWidth,
    );
  }

  /// Linearly interpolates between two [IslandNavThemeData] values.
  ///
  /// The [t] argument is between 0.0 and 1.0 inclusive.
  // ignore: prefer_constructors_over_static_methods
  static IslandNavThemeData lerp(
    IslandNavThemeData? a,
    IslandNavThemeData? b,
    double t,
  ) {
    if (identical(a, b)) return a ?? const IslandNavThemeData();
    return IslandNavThemeData(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      borderColor: Color.lerp(a?.borderColor, b?.borderColor, t),
      selectedColor: Color.lerp(a?.selectedColor, b?.selectedColor, t),
      unselectedColor: Color.lerp(a?.unselectedColor, b?.unselectedColor, t),
      labelStyle: TextStyle.lerp(a?.labelStyle, b?.labelStyle, t),
      selectedLabelStyle: TextStyle.lerp(
        a?.selectedLabelStyle,
        b?.selectedLabelStyle,
        t,
      ),
      elevation: _lerpDouble(a?.elevation, b?.elevation, t),
      borderRadius: _lerpDouble(a?.borderRadius, b?.borderRadius, t),
      navBarHeight: _lerpDouble(a?.navBarHeight, b?.navBarHeight, t),
      fabSpacing: _lerpDouble(a?.fabSpacing, b?.fabSpacing, t),
      bottomPadding: _lerpDouble(a?.bottomPadding, b?.bottomPadding, t),
      horizontalPadding: _lerpDouble(
        a?.horizontalPadding,
        b?.horizontalPadding,
        t,
      ),
      maxIslandWidth: _lerpDouble(a?.maxIslandWidth, b?.maxIslandWidth, t),
    );
  }

  static double? _lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    return (a ?? 0) + ((b ?? 0) - (a ?? 0)) * t;
  }
}
