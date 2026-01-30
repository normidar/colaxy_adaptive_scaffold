import 'package:flutter/material.dart';
import 'package:colaxy_adaptive_scaffold/src/navigation_item.dart';



/// A scaffold that adapts between a [BottomNavigationBar] and a [NavigationRail]
/// based on the screen aspect ratio (width/height).
///
/// This widget automatically determines the best navigation layout based on
/// the device's aspect ratio:
/// - **Portrait/Narrow screens** (aspect ratio < threshold): Uses [NavigationBar] at the bottom
/// - **Landscape/Wide screens** (aspect ratio >= threshold): Uses [NavigationRail] on the left side
///
/// The widget manages navigation state internally, so you don't need to handle
/// [selectedIndex] or [onDestinationSelected] callbacks yourself.
///
/// ## Parameters
///
/// ### Required Parameters
///
/// - **[items]**: A list of [NavigationItem] objects defining each navigation destination.
///   Each item contains a name (label), icon, and the page widget to display.
///
/// ### Optional Parameters
///
/// - **[initialIndex]**: The initially selected navigation item index (default: 0).
///   Must be a valid index within the [items] list.
///
/// - **[aspectRatioThreshold]**: The aspect ratio threshold for switching layouts (default: 1.2).
///   - If `width/height >= threshold`: Shows [NavigationRail] (side navigation)
///   - If `width/height < threshold`: Shows [NavigationBar] (bottom navigation)
///   - Common values:
///     - `1.0`: Switch at square screens
///     - `1.2`: Switch at slightly landscape screens (default)
///     - `1.5`: Switch only at wider landscape screens
///
/// - **[floatingActionButton]**: An optional [FloatingActionButton] to display.
///
/// ## Example
///
/// ```dart
/// AdaptiveScaffold(
///   items: [
///     NavigationItem(
///       name: 'Home',
///       icon: Icon(Icons.home),
///       page: HomePage(),
///     ),
///     NavigationItem(
///       name: 'Search',
///       icon: Icon(Icons.search),
///       page: SearchPage(),
///     ),
///     NavigationItem(
///       name: 'Settings',
///       icon: Icon(Icons.settings),
///       page: SettingsPage(),
///     ),
///   ],
///   initialIndex: 0,
///   aspectRatioThreshold: 1.2,
///   floatingActionButton: FloatingActionButton(
///     onPressed: () {},
///     child: Icon(Icons.add),
///   ),
/// )
/// ```
class AdaptiveScaffold extends StatefulWidget {
  /// Creates an adaptive scaffold.
  ///
  /// The [items] parameter is required and must contain at least one item.
  /// The [initialIndex] must be a valid index within [items].
  const AdaptiveScaffold({
    required this.items,
    this.initialIndex = 0,
    this.aspectRatioThreshold = 1.2,
    this.floatingActionButton,
    super.key,
  });

  /// The list of navigation items to display.
  ///
  /// Each [NavigationItem] defines a navigation destination with:
  /// - A name (label text)
  /// - An icon widget
  /// - A page widget to display when selected
  final List<NavigationItem> items;

  /// The initial selected index. Defaults to 0.
  ///
  /// This determines which navigation item is selected when the widget
  /// is first built. Must be a valid index within [items].
  final int initialIndex;

  /// The aspect ratio threshold to switch between bottom and side navigation.
  ///
  /// The aspect ratio is calculated as `width / height`.
  /// - If `aspectRatio >= threshold`: Uses [NavigationRail] (side navigation)
  /// - If `aspectRatio < threshold`: Uses [NavigationBar] (bottom navigation)
  ///
  /// Defaults to 1.2, which means landscape-ish layouts (wider than tall)
  /// will use side navigation, while portrait layouts use bottom navigation.
  final double aspectRatioThreshold;

  /// An optional floating action button.
  ///
  /// This button will be displayed in both navigation layouts
  /// (bottom and side navigation).
  final Widget? floatingActionButton;

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspectRatio = size.width / size.height;
    final useRail = aspectRatio >= widget.aspectRatioThreshold;

    // Get the current page to display
    final currentPage = widget.items[_selectedIndex].page;

    if (useRail) {
      // Use NavigationRail for wider/landscape layouts
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              destinations: widget.items
                  .map(
                    (item) => NavigationRailDestination(
                      icon: item.icon,
                      label: Text(item.name),
                    ),
                  )
                  .toList(),
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
              labelType: NavigationRailLabelType.all,
            ),
            VerticalDivider(width: 1, thickness: 1, color: Colors.grey[300]),
            Expanded(child: currentPage),
          ],
        ),
        floatingActionButton: widget.floatingActionButton,
      );
    }

    // Use BottomNavigationBar for taller/portrait layouts
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: NavigationBar(
        destinations: widget.items
            .map(
              (item) => NavigationDestination(
                icon: item.icon,
                label: item.name,
              ),
            )
            .toList(),
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
