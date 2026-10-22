import 'package:flutter/material.dart';

class WebFooter extends StatelessWidget {
  const WebFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmall = MediaQuery.of(context).size.width < 800;

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.4),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Main Footer Columns
              if (!isSmall)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand Info Column
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.language, color: Colors.white, size: 20),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'WebApp Portal',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Building seamless responsive multi-platform web applications powered by Flutter framework.',
                            style: TextStyle(
                              color: Colors.grey[600],
                              height: 1.5,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _SocialIconButton(icon: Icons.share, onTap: () {}),
                              _SocialIconButton(icon: Icons.code, onTap: () {}),
                              _SocialIconButton(icon: Icons.public, onTap: () {}),
                              _SocialIconButton(icon: Icons.email_outlined, onTap: () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),

                    // Products Column
                    Expanded(
                      flex: 2,
                      child: _FooterColumn(
                        title: 'Product',
                        links: const ['Overview', 'Features', 'Integrations', 'Pricing', 'Releases'],
                      ),
                    ),

                    // Company Column
                    Expanded(
                      flex: 2,
                      child: _FooterColumn(
                        title: 'Company',
                        links: const ['About Us', 'Careers', 'Blog', 'Press Kit', 'Contact'],
                      ),
                    ),

                    // Legal Column
                    Expanded(
                      flex: 2,
                      child: _FooterColumn(
                        title: 'Legal & Security',
                        links: const ['Privacy Policy', 'Terms of Service', 'Security', 'Cookies'],
                      ),
                    ),
                  ],
                )
              else
                // Compact Vertical Footer for Small Web Viewports
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WebApp Portal',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Responsive web experience powered by Flutter.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    const Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        Text('Product'),
                        Text('Company'),
                        Text('Privacy'),
                        Text('Terms'),
                        Text('Contact'),
                      ],
                    ),
                  ],
                ),

              const SizedBox(height: 40),
              Divider(color: Theme.of(context).dividerColor.withOpacity(0.3)),
              const SizedBox(height: 24),

              // Bottom Copyright Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© 2025 WebApp Portal, Inc. All rights reserved.',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'English (US)',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
                    ],
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

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: InkWell(
              onTap: () {},
              child: Text(
                link,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Icon(icon, size: 16, color: Colors.grey[700]),
        ),
      ),
    );
  }
}
