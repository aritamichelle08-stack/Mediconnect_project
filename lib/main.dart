import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Links your main file to your custom styling and routing files
import 'theme/app_theme.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This tricks Firebase into thinking it's active so it won't crash
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "demo-api-key",
        appId: "demo-app-id",
        messagingSenderId: "demo-sender-id",
        projectId: "demo-project",
      ),
    );
  } catch (e) {
    print("Firebase bypassed: $e");
  }

  runApp(const MyApp());
}

// Keeping the rest of your original application setup intact:
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
