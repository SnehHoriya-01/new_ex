import 'package:flutter/material.dart';
import '../responsive/responsive_layout.dart';

class ResponsiveDashboard extends StatefulWidget {
  const ResponsiveDashboard({super.key});

  @override
  State<ResponsiveDashboard> createState() => _ResponsiveDashboardState();
}

class _ResponsiveDashboardState extends State<ResponsiveDashboard> {
  int _selectedIndex = 0;

  final List<NavigationDestinationData> _destinations = const [
    NavigationDestinationData(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      label: 'Dashboard',
    ),
    NavigationDestinationData(
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics,
      label: 'Analytics',
    ),
    NavigationDestinationData(
      icon: Icons.folder_outlined,
      selectedIcon: Icons.folder,
      label: 'Projects',
    ),
    NavigationDestinationData(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_destinations[_selectedIndex].label),
        centerTitle: isMobile,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 8),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      drawer: isMobile ? _buildDrawer() : null,
      bottomNavigationBar: isMobile
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              destinations: _destinations
                  .map(
                    (item) => NavigationDestination(
                      icon: Icon(item.icon),
                      selectedIcon: Icon(item.selectedIcon),
                      label: item.label,
                    ),
                  )
                  .toList(),
            )
          : null,
      body: Row(
        children: [
          // Navigation Rail / Side Menu for Tablet & Web/Desktop
          if (!isMobile) _buildSideNavigation(context),

          // Main Body Content
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: ResponsiveLayout(
                  mobile: _buildMobileContent(),
                  tablet: _buildTabletContent(),
                  desktop: _buildDesktopContent(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Side Navigation Rail for Non-Mobile Devices
  Widget _buildSideNavigation(BuildContext context) {
    final bool isDesktop = ResponsiveLayout.isDesktop(context);

    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onItemTapped,
      extended: isDesktop,
      labelType: isDesktop ? NavigationRailLabelType.none : NavigationRailLabelType.selected,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
      destinations: _destinations
          .map(
            (item) => NavigationRailDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: Text(item.label),
            ),
          )
          .toList(),
    );
  }

  // Mobile Drawer
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('User Name'),
            accountEmail: Text('user@example.com'),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ...List.generate(_destinations.length, (index) {
            final item = _destinations[index];
            return ListTile(
              leading: Icon(item.icon),
              title: Text(item.label),
              selected: _selectedIndex == index,
              onTap: () {
                _onItemTapped(index);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }

  // --- Content Layouts ---

  // Mobile View: Single column layout
  Widget _buildMobileContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatGrid(crossAxisCount: 1),
          const SizedBox(height: 20),
          _buildMainChartCard(),
          const SizedBox(height: 20),
          _buildRecentActivityList(),
        ],
      ),
    );
  }

  // Tablet View: 2 column stat grid + stacked main sections
  Widget _buildTabletContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatGrid(crossAxisCount: 2),
          const SizedBox(height: 24),
          _buildMainChartCard(),
          const SizedBox(height: 24),
          _buildRecentActivityList(),
        ],
      ),
    );
  }

  // Desktop / Web View: 4 column stat grid + side-by-side main content & side panel
  Widget _buildDesktopContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatGrid(crossAxisCount: 4),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildMainChartCard(),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: _buildRecentActivityList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Reusable UI Widgets ---

  // Stat Summary Cards Grid
  Widget _buildStatGrid({required int crossAxisCount}) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.6,
      children: const [
        _StatCard(
          title: 'Total Revenue',
          value: '\$45,230',
          icon: Icons.attach_money,
          color: Colors.blue,
          change: '+12.5%',
        ),
        _StatCard(
          title: 'Active Users',
          value: '3,450',
          icon: Icons.people_outline,
          color: Colors.green,
          change: '+8.1%',
        ),
        _StatCard(
          title: 'New Orders',
          value: '1,280',
          icon: Icons.shopping_bag_outlined,
          color: Colors.orange,
          change: '+5.4%',
        ),
        _StatCard(
          title: 'Conversion Rate',
          value: '4.8%',
          icon: Icons.trending_up,
          color: Colors.purple,
          change: '+1.2%',
        ),
      ],
    );
  }

  // Main Chart / Analytics Container
  Widget _buildMainChartCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overview Analytics',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                DropdownButton<String>(
                  value: 'This Month',
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'This Week', child: Text('This Week')),
                    DropdownMenuItem(value: 'This Month', child: Text('This Month')),
                    DropdownMenuItem(value: 'This Year', child: Text('This Year')),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bar_chart, size: 64, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      'Chart visualization area',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Recent Activity List / Side Panel
  Widget _buildRecentActivityList() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final activities = [
                  ('Order #1024 completed', '2 minutes ago', Icons.check_circle_outline, Colors.green),
                  ('New user registered', '15 minutes ago', Icons.person_add_outlined, Colors.blue),
                  ('Payment received from John', '1 hour ago', Icons.payment, Colors.purple),
                  ('System backup finished', '3 hours ago', Icons.cloud_done_outlined, Colors.orange),
                ];
                final act = activities[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: act.$4.withOpacity(0.1),
                    child: Icon(act.$3, color: act.$4, size: 20),
                  ),
                  title: Text(act.$1, style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(act.$2, style: const TextStyle(fontSize: 12)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationDestinationData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const NavigationDestinationData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String change;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    change,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
