import 'package:flutter/material.dart';

class AndroidFooter extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AndroidFooter({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          elevation: 3,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.analytics_outlined),
              selectedIcon: Icon(Icons.analytics),
              label: 'Analytics',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ],
    );
  }
}

// Android In-List Mini Footer (for bottom of scrollable feeds)
class AndroidListFooter extends StatelessWidget {
  const AndroidListFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Divider(color: Theme.of(context).dividerColor.withOpacity(0.3)),
          const SizedBox(height: 12),
          Text(
            'Powered by Flutter Android',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '© 2025 Mobile App, Inc. All rights reserved.',
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
