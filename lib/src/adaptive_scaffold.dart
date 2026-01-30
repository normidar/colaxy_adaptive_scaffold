import 'package:flutter/material.dart';

/// A scaffold that adapts between a [BottomNavigationBar] and a [NavigationRail]
/// based on the screen width.
class AdaptiveScaffold extends StatelessWidget {
  /// Creates an adaptive scaffold.
  const AdaptiveScaffold({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
    this.breakpoint = 600,
    this.floatingActionButton,
    super.key,
  });

  /// The list of destinations to show in the navigation.
  final List<NavigationDestination> destinations;

  /// The index of the currently selected destination.
  final int selectedIndex;

  /// Called when a destination is selected.
  final ValueChanged<int> onDestinationSelected;

  /// The widget to display in the body of the scaffold.
  final Widget body;

  /// The width breakpoint to switch between [BottomNavigationBar] and [NavigationRail].
  /// Defaults to 600.
  final double breakpoint;

  /// An optional floating action button.
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final useRail = width >= breakpoint;

    if (useRail) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              destinations: destinations
                  .map(
                    (d) => NavigationRailDestination(
                      icon: d.icon,
                      selectedIcon: d.selectedIcon,
                      label: Text(d.label),
                    ),
                  )
                  .toList(),
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
            ),
            VerticalDivider(width: 1, thickness: 1, color: Colors.grey[300]),
            Expanded(child: body),
          ],
        ),
        floatingActionButton: floatingActionButton,
      );
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        destinations: destinations,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
