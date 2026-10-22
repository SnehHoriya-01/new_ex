import 'package:flutter/material.dart';
import '../../components/web_header.dart';
import '../../components/web_footer.dart';

class WebHomeScreen extends StatelessWidget {
  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WebHeader(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text('WebApp Navigation', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Home')),
            ListTile(leading: Icon(Icons.featured_play_list), title: Text('Features')),
            ListTile(leading: Icon(Icons.attach_money), title: Text('Pricing')),
            ListTile(leading: Icon(Icons.contact_mail), title: Text('Contact')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Web Hero Section
            const _WebHeroSection(),

            // 2. Web Features Section
            const _WebFeaturesSection(),

            // 3. Web Analytics / Dashboard Demo Section
            const _WebDashboardPreviewSection(),

            // 4. Web Footer Section
            const WebFooter(),
          ],
        ),
      ),
    );
  }
}

// Hero Section Component
class _WebHeroSection extends StatelessWidget {
  const _WebHeroSection();

  @override
  Widget build(BuildContext context) {
    final bool isSmall = MediaQuery.of(context).size.width < 900;

    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '⚡ Built for Web & Android',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Modern Responsive Web Application',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.15,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Deliver high performance web experiences with custom web headers, rich multi-column footers, and tailored layouts for desktop viewports.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.rocket_launch),
                          label: const Text('Explore Demo'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.code),
                          label: const Text('View Source'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isSmall) ...[
                const SizedBox(width: 40),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 340,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      ),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.desktop_mac, size: 80, color: Colors.deepPurple),
                          SizedBox(height: 16),
                          Text(
                            'Web Desktop Canvas',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Features Grid Component
class _WebFeaturesSection extends StatelessWidget {
  const _WebFeaturesSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final int crossAxisCount = width > 1000 ? 3 : (width > 600 ? 2 : 1);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Designed for Web Performance',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Seamlessly adapts across browser windows and screen dimensions.',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 48),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.4,
                children: const [
                  _FeatureCard(
                    icon: Icons.web,
                    title: 'Dedicated Web Header',
                    description: 'Full width header with navigation links, search, and CTA button.',
                  ),
                  _FeatureCard(
                    icon: Icons.view_headline,
                    title: 'Rich Multi-Column Footer',
                    description: 'Comprehensive footer with social links, company details, and copyright.',
                  ),
                  _FeatureCard(
                    icon: Icons.phone_android,
                    title: 'Android Separation',
                    description: 'Isolated Android file with native mobile navigation bar & sliver bars.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(icon, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

// Dashboard Preview Component
class _WebDashboardPreviewSection extends StatelessWidget {
  const _WebDashboardPreviewSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Live Analytics Dashboard',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _WebStatCard(title: 'Web Traffic', value: '128,450', change: '+14%'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _WebStatCard(title: 'Android Downloads', value: '45,200', change: '+22%'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _WebStatCard(title: 'Active Sessions', value: '8,920', change: '+9%'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WebStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;

  const _WebStatCard({
    required this.title,
    required this.value,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 4),
            Text(change, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
