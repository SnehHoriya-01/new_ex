import 'package:flutter/material.dart';
import '../../components/android_header.dart';
import '../../components/android_footer.dart';

class AndroidHomeScreen extends StatefulWidget {
  const AndroidHomeScreen({super.key});

  @override
  State<AndroidHomeScreen> createState() => _AndroidHomeScreenState();
}

class _AndroidHomeScreenState extends State<AndroidHomeScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AndroidHeader(title: 'Android Dashboard'),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Android Hero Greeting Banner
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, Mobile User! 👋',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Welcome to your Android native view built with Flutter.',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.smartphone,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Quick Actions Horizontal Scroll
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _QuickActionButton(icon: Icons.send, label: 'Send', color: Colors.blue),
                  _QuickActionButton(icon: Icons.qr_code_scanner, label: 'Scan', color: Colors.green),
                  _QuickActionButton(icon: Icons.receipt_long, label: 'Bills', color: Colors.orange),
                  _QuickActionButton(icon: Icons.account_balance_wallet, label: 'Wallet', color: Colors.purple),
                  _QuickActionButton(icon: Icons.more_horiz, label: 'More', color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Android Feed / List Items
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final items = [
                    ('Transfer Received', '+\$250.00', 'Today, 2:30 PM', Icons.arrow_downward, Colors.green),
                    ('Subscription Paid', '-\$14.99', 'Yesterday', Icons.subscriptions, Colors.red),
                    ('Grocery Shopping', '-\$84.20', 'Oct 24', Icons.shopping_bag, Colors.orange),
                    ('Salary Credit', '+\$3,500.00', 'Oct 20', Icons.work, Colors.blue),
                    ('Online Purchase', '-\$45.00', 'Oct 18', Icons.credit_card, Colors.purple),
                  ];
                  final item = items[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: item.$5.withOpacity(0.1),
                      child: Icon(item.$4, color: item.$5, size: 20),
                    ),
                    title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(item.$3, style: const TextStyle(fontSize: 12)),
                    trailing: Text(
                      item.$2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: item.$2.startsWith('+') ? Colors.green : Colors.black87,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            // Android In-List Footer
            const AndroidListFooter(),
          ],
        ),
      ),
      bottomNavigationBar: AndroidFooter(
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
