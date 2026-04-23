/// Controls when labels are shown for island nav destinations.
enum IslandNavLabelBehavior {
  /// Always show labels beneath every destination icon.
  ///
  /// This is the default behaviour.
  alwaysShow,

  /// Never show labels. Only icons are rendered.
  alwaysHide,

  /// Show a label only for the currently selected destination.
  onlyShowSelected,
}
