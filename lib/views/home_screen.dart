import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../responsive/responsive_layout.dart';
import 'android/android_home_screen.dart';
import 'web/web_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // If running directly on web or on desktop-sized viewports, display WebHomeScreen.
    // If running on mobile/Android viewports, display AndroidHomeScreen.
    return ResponsiveLayout(
      mobile: const AndroidHomeScreen(),
      tablet: kIsWeb ? const WebHomeScreen() : const AndroidHomeScreen(),
      desktop: const WebHomeScreen(),
    );
  }
}
