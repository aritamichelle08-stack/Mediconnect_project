import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chronic Disease App',
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      routes: AppRoutes.routes,
    );
  }
}