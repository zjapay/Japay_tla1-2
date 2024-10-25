import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home.dart';
import 'models/bmi_model.dart'; // Import the BMI model
import 'themes/app_theme.dart'; // Import the app theme

// Define your Riverpod provider
final bmiProvider = ChangeNotifierProvider<BMIMeasurement>((ref) {
  return BMIMeasurement();
});

void main() {
  runApp(
    ProviderScope(
      // Use ProviderScope to allow Riverpod to work
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie & BMI Tracker',
      theme: AppTheme.theme, // Ensure this is defined correctly
      home: const HomeScreen(), // Ensure HomeScreen is defined and imported
    );
  }
}
