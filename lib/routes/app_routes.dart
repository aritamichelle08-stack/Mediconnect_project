import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/home_screen.dart';
import '../screens/caregiver_dashboard_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/splash': (context) => const SplashScreen(),
    '/onboarding': (context) => const OnboardingScreen(),
    '/welcome': (context) => const WelcomeScreen(),
    '/patient-login': (context) =>
        const Scaffold(body: Center(child: Text('Patient login coming soon'))),
    // 2. Swapped the hardcoded placeholder for your actual widget
    '/caregiver-login': (context) => const CaregiverDashboardScreen(caregiverId: 'placeholder_id'),
    '/home': (context) => const HomeScreen(),
  };
}
