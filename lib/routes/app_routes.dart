import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/home_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/splash': (context) => const SplashScreen(),
    '/onboarding': (context) => const OnboardingScreen(),
    '/welcome': (context) => const WelcomeScreen(),
    '/patient-login': (context) => const Scaffold(
      body: Center(child: Text('Patient login coming soon')),
    ),
    '/caregiver-login': (context) => const Scaffold(
      body: Center(child: Text('Caregiver login coming soon')),
    ),
    '/home': (context) => const HomeScreen(),
  };
}